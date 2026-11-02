/**
 * The songs are sung in English only (the owner, 2026-11-02). Is a text English? The words that mark Norwegian and
 * Latin (function words, pronouns, and the words for God and the Lord) are counted against the words that mark
 * English; a text with more than a few of them is not English. Used by validate-catalog.ts and catalog-write.ts
 * on the lyrics asked for, and by generate.ts on what Whisper heard.
 */
const ENGLISH = new Set(('the and of to a in is you that it he was for on are with as his they be at have this from or had by not '
  + 'but what all were we when your can said there an which she do how their if will up my me him who our i us lord god shall '
  + 'thy thee o let he his her its into over under no yes now come')
  .split(' '));
const NORWEGIAN = new Set(('og er det som til på med av ikke jeg du han hun meg deg seg oss ham hans hennes min din mitt ditt '
  + 'herren herre gud skal vil har var så når hvor fra mot alle være ære sjel livet himmelen jorden dere vår vårt hjertet '
  + 'nåde fred kjærlighet ord evig deres hva hvem gjennom aldri alltid')
  .split(' '));
const LATIN = new Set(('et est non qui quae quod cum ad ex per sed sicut meus mea meum tuus tua tuum nobis nos vos dominus '
  + 'domine domini deus deo dei deum gloria sanctus nomen caeli celi terra pax hominibus ego sum es sunt ut enim quia autem '
  + 'omnes anima mihi tibi secundum misericordia excelsis voluntatis peccata mundi agnus fiat regnum panem nostrum')
  .split(' '));

/** Why a text is not English, or undefined when it is. */
export function notEnglish(text: string): string | undefined {
  const words = text.toLowerCase().replace(/\[[^\]]*\]/g, ' ').match(/[a-zæøåéèáàäöü]+/g) ?? [];
  const found = (set: Set<string>) => words.filter((w) => set.has(w));
  const english = found(ENGLISH).length;
  for (const [language, set] of [['Norwegian', NORWEGIAN], ['Latin', LATIN]] as const) {
    const foreign = found(set);
    if (foreign.length >= 3 && foreign.length >= english * 0.1) {
      return `${language} words (${[...new Set(foreign)].slice(0, 6).join(', ')}: ${foreign.length}, against ${english} English)`;
    }
  }
}

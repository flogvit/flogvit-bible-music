// The English-only rule: lyrics asked for and singing heard in another language are caught without the judge.
//   bun test scripts/lyrics-language.test.ts
import { describe, expect, test } from 'bun:test';
import { languageVerdict, outcome } from './lyrics-check';
import { notEnglish } from './lyrics-language';

const PSALM_23 = '[Verse]\nThe LORD is my shepherd, I lack nothing\nHe lets me lie down in green pastures\nHe restores my soul';
// Psalm 23 as one of the prayer-house songs had it, from osnb.
const SALME_23 = '[Verse]\nHerren er min hyrde, jeg mangler ingen ting\nHan lar meg ligge i grønne enger\nHan fører meg til vann der jeg finner hvile';
// The Lord's Prayer as the Gregorian chant had it, from the Vulgate.
const PATER = '[Verse]\nPater noster qui es in caelis\nSanctificetur nomen tuum\nAdveniat regnum tuum\nFiat voluntas tua';
const heard = (text: string) => ({ 'large-v3|None|None|0': text.split(' ').map((w, i) => ({ w, s: i, e: i + 0.5, p: 0.9 })) });

describe('notEnglish', () => {
  test('English lyrics pass, also with a word or two of Hebrew, Greek or Latin in them', () => {
    expect(notEnglish(PSALM_23)).toBeUndefined();
    expect(notEnglish(`${PSALM_23}\n\n[Chorus]\nHallelujah, Amen, Hosanna\nGloria to the Lamb\nAbba, Father, take away my sin`)).toBeUndefined();
  });

  test('Norwegian and Latin lyrics are caught, with the words that gave them away', () => {
    expect(notEnglish(SALME_23)).toStartWith('Norwegian words (herren, er, min, jeg, han, meg');
    expect(notEnglish(PATER)).toStartWith('Latin words (pater, noster, qui, es, nomen, tuum');
  });

  test('an English song with a Latin chorus is caught too', () => {
    expect(notEnglish(`${PSALM_23}\n\n[Chorus]\nGloria in excelsis Deo\nEt in terra pax hominibus`)).toStartWith('Latin words');
  });
});

describe('titles', () => {
  test('the Norwegian, Latin and Hebrew titles the catalog had are caught', () => {
    for (const title of ['Herren er min hyrde', 'Kom til meg', 'Far, jeg har syndet', 'Jeg løfter mine øyne mot fjellene',
      'Pater Noster', 'Magnificat', 'O Vos Omnes', 'Ecce Agnus Dei', 'Gloria in Altissimis Deo', 'Hine Ma Tov']) {
      expect(notEnglish(title)).toBeDefined();
    }
  });

  test('English titles pass, also with names and the Hebrew and Greek words English Bibles keep', () => {
    for (const title of ['A Long Way Off', 'Rabboni', 'Immanuel', 'Hosanna in the Highest', 'Beer-lahai-roi', 'Keren-Happuch',
      'Far Beyond All That We Ask', 'Greet Hermes', 'Hallowed Be Your Name', 'God Is Love', 'Behold, How Good']) {
      expect(notEnglish(title)).toBeUndefined();
    }
  });
});

describe('languageVerdict', () => {
  test('an English song sung in English goes on to the judge', () => {
    expect(languageVerdict(PSALM_23, heard('The LORD is my shepherd I lack nothing'), { language: 'en', probability: 0.96 })).toBeUndefined();
  });

  test('lyrics asked for in Norwegian are wrong before anything is heard', () => {
    expect(outcome(languageVerdict(SALME_23, heard('Herren er min hyrde'))!)).toBe('reject');
  });

  test('English lyrics sung in Latin are wrong: by what Whisper writes without the lyrics, or with them', () => {
    const sung = { language: 'la', probability: 0.97, heard: 'Pater noster, qui es in caelis, sanctificetur nomen tuum, adveniat regnum tuum' };
    expect(languageVerdict(PSALM_23, heard('The LORD is my shepherd'), sung)!.summary).toStartWith('Whisper hears the singing, without the lyrics to go by, as not English (la)');
    expect(outcome(languageVerdict(PSALM_23, heard('Pater noster qui es in caelis sanctificetur nomen tuum fiat voluntas tua'))!)).toBe('reject');
  });

  test('a language that is neither English, Norwegian nor Latin is caught by its few English words', () => {
    const sung = { language: 'de', probability: 0.95, heard: 'Der Herr ist mein Hirte, mir wird nichts mangeln. Er weidet mich auf einer grünen Aue und führet mich zum frischen Wasser.' };
    expect(languageVerdict(PSALM_23, heard('The LORD is my shepherd'), sung)!.summary).toContain('few English words');
  });

  test('English Gregorian chant that Whisper guesses is Latin, but writes down in English, is not rejected', () => {
    // The Lord's Prayer as Gregorian chant on the Home Mac, 2026-11-02: guessed Latin (0.888), heard in English.
    const sung = { language: 'la', probability: 0.888, heard: 'Our Father in heaven, Hallowed be your name, your kingdom come, your will be done, on earth as it is in heaven. Give us today our daily bread, and forgive us our debts, as we also have forgiven our debtors. And lead us not into temptation But deliver us from evil' };
    expect(languageVerdict(PSALM_23, heard('Our Father in heaven hallowed be your name'), sung)).toBeUndefined();
  });
});

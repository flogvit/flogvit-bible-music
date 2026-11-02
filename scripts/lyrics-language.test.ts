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
    expect(notEnglish(PATER)).toStartWith('Latin words (qui, es, nomen, tuum, regnum, fiat');
  });

  test('an English song with a Latin chorus is caught too', () => {
    expect(notEnglish(`${PSALM_23}\n\n[Chorus]\nGloria in excelsis Deo\nEt in terra pax hominibus`)).toStartWith('Latin words');
  });
});

describe('languageVerdict', () => {
  test('an English song sung in English goes on to the judge', () => {
    expect(languageVerdict(PSALM_23, heard('The LORD is my shepherd I lack nothing'), { language: 'en', probability: 0.96 })).toBeUndefined();
  });

  test('lyrics asked for in Norwegian are wrong before anything is heard', () => {
    expect(outcome(languageVerdict(SALME_23, heard('Herren er min hyrde'))!)).toBe('reject');
  });

  test('English lyrics sung in Latin are wrong: by the language Whisper hears, or by the words it writes', () => {
    expect(languageVerdict(PSALM_23, heard('Dominus regit me'), { language: 'la', probability: 0.97 })!.summary)
      .toBe('Whisper hears the singing as "la" (0.97), not English.');
    expect(outcome(languageVerdict(PSALM_23, heard('Pater noster qui es in caelis sanctificetur nomen tuum fiat voluntas tua'))!)).toBe('reject');
  });

  test('an unsure language guess (instrumental, a word or two) does not reject an English song', () => {
    expect(languageVerdict(PSALM_23, heard('The LORD is my shepherd'), { language: 'cy', probability: 0.31 })).toBeUndefined();
  });
});

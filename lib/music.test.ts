import { describe, expect, test } from "bun:test";
import { buildIndex, lineTimes, overlaps, parseVerse, search, type Song } from "./music";

const song = (id: string, over: Partial<Song>): Song => ({
  id, collection: "bible", title: id, references: [], style: [], tags: {}, files: { mp3: `bible/${id}/audio.mp3`, info: "" },
  ...over,
});

const index = buildIndex({
  bible: [
    song("bread", {
      title: "Bread of Life", kind: "story", style: ["worship"], lyrics: "They followed him across the sea",
      references: [{ bookId: 43, chapter: 6, verseStart: 22, verseEnd: 59, label: "John 6:22-59", url: "https://bible.flogvit.com/en/joh/6#v22" }],
      tags: { theme: ["salvation"], themes: [{ slug: "frelsen", title: "Salvation" }], persons: [{ slug: "jesus", title: "Jesus" }] },
    }),
    song("love", {
      title: "The Greatest of These", kind: "chapter", style: ["soul"],
      references: [{ bookId: 46, chapter: 13, label: "1 Corinthians 13", url: "https://bible.flogvit.com/en/1kor/13" }],
      tags: { theme: ["love"] },
    }),
  ],
  other: [song("jazz", { collection: "other", title: "Interfaces in Bloom", style: ["jazz"] })],
});

describe("index", () => {
  test("books come from the passages", () => {
    expect(index.books["43"]).toEqual({ name: "John", short: "joh" });
    expect(index.books["46"]).toEqual({ name: "1 Corinthians", short: "1kor" });
  });
  test("lists every collection", () => expect(index.collections).toEqual(["bible", "other"]));
});

describe("parseVerse", () => {
  test("full name, short name and prefix", () => {
    expect(parseVerse("John 6:35", index.books)).toEqual({ bookId: 43, chapter: 6, verseStart: 35, verseEnd: 35 });
    expect(parseVerse("joh 6", index.books)).toEqual({ bookId: 43, chapter: 6, verseStart: undefined, verseEnd: undefined });
    expect(parseVerse("1 Cor 13:4-7", index.books)).toEqual({ bookId: 46, chapter: 13, verseStart: 4, verseEnd: 7 });
  });
  test("an unknown book is no match", () => expect(parseVerse("Genesis 1:1", index.books)).toBeNull());
});

describe("overlaps", () => {
  const p = { bookId: 43, chapter: 6, verseStart: 22, verseEnd: 59 };
  test("inside, touching and outside", () => {
    expect(overlaps(p, { bookId: 43, chapter: 6, verseStart: 35, verseEnd: 35 })).toBe(true);
    expect(overlaps(p, { bookId: 43, chapter: 6, verseStart: 59, verseEnd: 70 })).toBe(true);
    expect(overlaps(p, { bookId: 43, chapter: 6, verseStart: 60, verseEnd: 70 })).toBe(false);
    expect(overlaps(p, { bookId: 43, chapter: 7 })).toBe(false);
  });
  test("a whole-chapter passage covers every verse", () =>
    expect(overlaps({ bookId: 46, chapter: 13 }, { bookId: 46, chapter: 13, verseStart: 4, verseEnd: 4 })).toBe(true));
});

describe("search", () => {
  const ids = (q: Parameters<typeof search>[1]) => search(index, q).map((s) => s.id);
  test("by verse", () => expect(ids({ verse: "John 6:35" })).toEqual(["bread"]));
  test("by words in lyrics and title", () => {
    expect(ids({ text: "sea" })).toEqual(["bread"]);
    expect(ids({ text: "greatest" })).toEqual(["love"]);
  });
  test("by theme tag, theme title, person and style", () => {
    expect(ids({ theme: "salvation" })).toEqual(["bread"]);
    expect(ids({ theme: "frelsen" })).toEqual(["bread"]);
    expect(ids({ person: "jesus" })).toEqual(["bread"]);
    expect(ids({ style: "Soul" })).toEqual(["love"]);
  });
  test("by collection", () => expect(ids({ collection: "other" })).toEqual(["jazz"]));
  test("a verse no book matches finds nothing", () => expect(ids({ verse: "Genesis 1:1" })).toEqual([]));
});

describe("lineTimes", () => {
  test("hands each line its syllables, on the audio's clock", () => {
    const lines = lineTimes({
      offset_seconds: -1,
      lines: [{ text: "They followed him" }, { text: "across the sea", uncertain: true }],
      syllables: [["They", 21], ["fol", 22], ["lowed", 22.5], ["him", 23], ["ac", 24], ["ross", 24.5], ["the", 25], ["sea", 26]]
        .map(([text, time]) => ({ text: text as string, time: time as number })),
    })!;
    expect(lines.map((l) => l.syllables.length)).toEqual([4, 4]);
    expect(lines[0].syllables[1]).toEqual({ letters: "fol", time: 21 });
    expect(lines[1].uncertain).toBe(true);
  });
  test("a line its syllables do not spell gives null", () =>
    expect(lineTimes({ lines: [{ text: "Hello" }], syllables: [{ text: "Bye", time: 1 }] })).toBeNull());
});

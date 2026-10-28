# Which machine generates what

Audio is not in git, so each machine says here which catalog songs it has taken, to avoid generating the
same song twice. Before starting a batch, pull main and skip songs another machine has taken; add your own and
push before you start. A song is `taken` while it waits or generates, and `done` when its audio and sheets are
made.

Every song made before 2026-10-28 16:20 ran on torch 2.10 and counts as not done (see README).

## Home Mac (M1 Max, 64 GB)

Started 2026-10-28 with `configs/long-12000.json`, torch 2.14.1, one song at a time under `taskpolicy -b`,
in this order (reverse catalog order, so a machine working through the catalog from the top meets it in the
middle), then the catalog portions added after it, most-known songs first. Output: `YuE/outputs/catalog/<id>/`
on Home Mac.

| song | status |
|---|---|
| verse-43-3-16-gospel | done 2026-10-28 17:59, 3:18, sheets in sheets/ |
| verse-40-11-28-folk | done 2026-10-28 18:29, 3:02, sheets in sheets/ |
| verse-24-29-11-gospel | done 2026-10-28 19:00, 4:04, sheets in sheets/ |
| theme-tilgivelse-country | done 2026-10-28 19:42, 2:59, sheets in sheets/ |
| story-david-og-goliat-children | done 2026-10-28 20:13, 2:04, sheets in sheets/ |
| person-rut-celtic | taken |
| chapter-46-13-soul | taken |
| chapter-19-23-worship | taken |
| chapter-19-104-orchestral-folk | taken |
| chapter-19-103-gospel | taken |

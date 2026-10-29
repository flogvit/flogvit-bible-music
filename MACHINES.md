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
| person-rut-celtic | done 2026-10-28 20:55, 3:24, sheets in sheets/ |
| chapter-46-13-soul | done 2026-10-28 21:42, 3:54, sheets in sheets/ |
| chapter-19-23-worship | done 2026-10-28 22:10, 3:36, sheets in sheets/ |
| chapter-19-104-orchestral-folk | done 2026-10-28 23:27, 7:47, sheets in sheets/ |
| chapter-19-103-gospel | done 2026-10-29 00:01, 3:47, sheets in sheets/ |
| story-jesu-fodsel-celtic | done 2026-10-29 00:29, 3:14, sheets in sheets/ |
| story-jesu-oppstandelse-gospel | done 2026-10-29 00:51, 2:46, sheets in sheets/ |
| story-korsfestelsen-ballad | done 2026-10-29 01:21, 3:48, sheets in sheets/ |
| verse-40-6-9-choral | done 2026-10-29 01:43, 3:01, sheets in sheets/ |
| verse-50-4-13-pop | taken |
| verse-45-8-28-soul | taken |
| verse-23-40-31-worship | taken |
| verse-20-3-5-country | taken |
| verse-4-6-24-celtic | taken |
| verse-40-5-3-folk | taken |
| verse-6-1-9-rock | taken |
| story-den-fortapte-sonn-country | taken |
| story-den-barmhjertige-samaritan-folk | taken |
| story-noas-ark-og-syndfloden-children | taken |
| story-skapelsen-av-verden-orchestral | taken |
| story-israelittene-gar-gjennom-rodehavet-gospel | taken |
| story-daniel-i-lovehulen-soul | taken |
| story-jona-i-fiskens-buk-children | taken |
| person-moses-folk | taken |
| person-maria-jesu-mor-ballad | taken |
| person-peter-acoustic | taken |
| person-paulus-rock | taken |
| theme-jul-orchestral | taken |
| theme-nade-soul | taken |
| theme-pinse-worship | taken |

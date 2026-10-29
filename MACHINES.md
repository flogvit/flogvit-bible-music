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
| verse-50-4-13-pop | done 2026-10-29 02:02, 2:24, sheets in sheets/ |
| verse-45-8-28-soul | done 2026-10-29 02:30, 3:33, sheets in sheets/ |
| verse-23-40-31-worship | done 2026-10-29 03:05, 4:11, sheets in sheets/ |
| verse-20-3-5-country | done 2026-10-29 03:33, 3:27, sheets in sheets/ |
| verse-4-6-24-celtic | done 2026-10-29 03:53, 2:37, sheets in sheets/ |
| verse-40-5-3-folk | done 2026-10-29 04:22, 3:29, sheets in sheets/ |
| verse-6-1-9-rock | done 2026-10-29 04:59, 4:08, sheets in sheets/ |
| story-den-fortapte-sonn-country | done 2026-10-29 05:27, 3:29, sheets in sheets/ |
| story-den-barmhjertige-samaritan-folk | done 2026-10-29 05:51, 2:53, sheets in sheets/ |
| story-noas-ark-og-syndfloden-children | done 2026-10-29 06:04, 1:36, sheets in sheets/ |
| story-skapelsen-av-verden-orchestral | done 2026-10-29 06:37, 4:07, sheets in sheets/ |
| story-israelittene-gar-gjennom-rodehavet-gospel | done 2026-10-29 07:04, 3:25, sheets in sheets/ |
| story-daniel-i-lovehulen-soul | done 2026-10-29 07:49, 4:54, sheets in sheets/ |
| story-jona-i-fiskens-buk-children | done 2026-10-29 08:08, 2:27, sheets in sheets/ |
| person-moses-folk | taken |
| person-maria-jesu-mor-ballad | taken |
| person-peter-acoustic | taken |
| person-paulus-rock | taken |
| theme-jul-orchestral | taken |
| theme-nade-soul | taken |
| theme-pinse-worship | taken |

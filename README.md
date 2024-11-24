# Duckit

I've been throughly [duckpilled]([url](https://duckdb.org)). I've spent the better part of the last year wrangling a LOT of
CSVs and let me tell you, duckdb has been right there with me, helping me along the way.

<img src="https://media.tenor.com/xZtJvkD2wkwAAAAe/what-we-do-in-the-shadows-laszlo-cravensworth.png">

_me, talking about duckdb to anyone who will listen_

And after a year of doing this DAY AFTER DAY AFTER DAY

```
❯ duckdb
v1.1.3 19864453f7
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
D create table t as select * from read_csv('ome_more_csv');
```

I decided that enough was enough and I made `duckit`. BEHOLD MY MONSTROUS CREATION!

## Questions
Does it clean up after itself? Of course not!
Does it check inputs? Psh.
What happens if `duckdb` isn't installed? You'll probably die who can tell?!?

## Why my guy

But it lets me do this, which I've been dying to do for months now:

```
❯ source duckit.sh
❯ duckit free_company_dataset.csv
100% ▕████████████████████████████████████████████████████████████▏
v1.1.3 19864453f7
Enter ".help" for usage hints.
D summarize t;
┌──────────────┬─────────────┬─────────────────────────────────────────────────────────────────────┬────────────────────────────────────────────────────────────────────────────────┬───────────────┬────────────────────┬────────────────────┬─────────┬─────────┬─────────┬──────────┬─────────────────┐
│ column_name  │ column_type │                                 min                                 │                                      max                                       │ approx_unique │        avg         │        std         │   q25   │   q50   │   q75   │  count   │ null_percentage │
│   varchar    │   varchar   │                               varchar                               │                                    varchar                                     │     int64     │      varchar       │      varchar       │ varchar │ varchar │ varchar │  int64   │  decimal(9,2)   │
├──────────────┼─────────────┼─────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────┼───────────────┼────────────────────┼────────────────────┼─────────┼─────────┼─────────┼──────────┼─────────────────┤
│ country      │ VARCHAR     │ afghanistan                                                         │ åland islands                                                                  │           283 │                    │                    │         │         │         │ 22734322 │            9.98 │
│ founded      │ BIGINT      │ 1001                                                                │ 2024                                                                           │           937 │ 2006.3161400677536 │ 24.825956869579304 │ 2003    │ 2013    │ 2018    │ 22734322 │           60.79 │
│ id           │ VARCHAR     │ 000053ktcMRCSIbGGboE0QlBPQlh                                        │ zzzzgepytuhECxjtjLcHyAGn554K                                                   │      22169331 │                    │                    │         │         │         │ 22734322 │            0.00 │
│ industry     │ VARCHAR     │ "glass                                                              │ writing and editing                                                            │           164 │                    │                    │         │         │         │ 22734322 │           23.83 │
│ linkedin_url │ VARCHAR     │  ceramics & concrete"                                               │ linkedin.com/company/���ashiraj-education-overseas-consultants-private-limited │      26144844 │                    │                    │         │         │         │ 22734322 │            0.00 │
│ locality     │ VARCHAR     │ "aeroporto \"b\""                                                   │ ’aïn el melh                                                                   │        248569 │                    │                    │         │         │         │ 22734322 │           32.66 │
│ name         │ VARCHAR     │  el"                                                                │ 🫧sl-wash🫧 spécialiste station de lavage auto                                 │      24204406 │                    │                    │         │         │         │ 22734322 │            0.13 │
│ region       │ VARCHAR     │                                 registered estate surveyors & val…  │ 🧚♀️maison sérénité opôno  🪷                                                   │        139478 │                    │                    │         │         │         │ 22734322 │           22.99 │
│ size         │ VARCHAR     │ 1-10                                                                │ žilinský                                                                       │          2558 │                    │                    │         │         │         │ 22734322 │            0.38 │
│ website      │ VARCHAR     │ "google.com/maps/place/28°36'36.4\"n+77°01'43.6\"e/@28.610122.77.…  │ 👁👄👁.fm                                                                        │      20771265 │                    │                    │         │         │         │ 22734322 │           30.49 │
├──────────────┴─────────────┴─────────────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────────────────────┴───────────────┴────────────────────┴────────────────────┴─────────┴─────────┴─────────┴──────────┴─────────────────┤
│ 10 rows                                                                                                                                                                                                                                                                                     12 columns │
└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
D select count(0) from t;
┌──────────┐
│ count(0) │
│  int64   │
├──────────┤
│ 22734322 │
└──────────┘
```

It can even do json!

```
❯ duckit gists.json
v1.1.3 19864453f7
Enter ".help" for usage hints.
D select * from t;
┌──────────────────────┬──────────────────────┬──────────────────────┬──────────────────────┬──────────────────────┬──────────────────────┬──────────────────────┬───┬─────────────────────┬──────────────────────┬──────────┬──────┬──────────────────────┬──────────────────────┬───────────┐
│         url          │      forks_url       │     commits_url      │          id          │       node_id        │     git_pull_url     │     git_push_url     │ … │     updated_at      │     description      │ comments │ user │     comments_url     │        owner         │ truncated │
│       varchar        │       varchar        │       varchar        │       varchar        │       varchar        │       varchar        │       varchar        │   │      timestamp      │       varchar        │  int64   │ json │       varchar        │ struct(login varch…  │  boolean  │
├──────────────────────┼──────────────────────┼──────────────────────┼──────────────────────┼──────────────────────┼──────────────────────┼──────────────────────┼───┼─────────────────────┼──────────────────────┼──────────┼──────┼──────────────────────┼──────────────────────┼───────────┤
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ ee86f0e9dd841661e9…  │ G_kwDNAdPaACBlZTg2…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2024-11-24 18:05:13 │ Duckit               │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 51b2f3fa672ad6e359…  │ G_kwDNAdPaACA1MWIy…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2024-11-05 19:29:08 │ mando.git.ht: logi…  │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ ae9712f7ff00430bac…  │ G_kwDNAdPaACBhZTk3…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2024-11-05 19:28:54 │ Testing testing te…  │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ f0bebf661fbb351165…  │ G_kwDNAdPaACBmMGJl…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2024-03-22 15:01:42 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ c6c55590e0072be1ad…  │ G_kwDNAdPaACBjNmM1…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2024-01-04 17:41:12 │ mando.git.ht: logi…  │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 50b947bba620eec256…  │ G_kwDNAdPaACA1MGI5…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2023-11-16 17:39:04 │ Githoot - the blog…  │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ d997732792dc12c896…  │ MDQ6R2lzdGQ5OTc3Mz…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2021-08-12 18:08:33 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 71f7421580c0371ad7…  │ MDQ6R2lzdDcxZjc0Mj…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2021-08-12 17:50:53 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 61358dd5bc19f6dd84…  │ MDQ6R2lzdDYxMzU4ZG…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2024-10-29 17:07:37 │ 4 months into work…  │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ a5bb9dfc2bd8f2ebd1…  │ MDQ6R2lzdGE1YmI5ZG…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2020-07-22 18:06:06 │ how to cleanup you…  │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ f28b701828986c3872…  │ MDQ6R2lzdGYyOGI3MD…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2020-04-17 21:30:31 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ a7402b9ed557c2ded7…  │ MDQ6R2lzdGE3NDAyYj…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2024-11-07 14:14:16 │ Old Timer Drinking…  │      321 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 002d6ea1a6da89a97d…  │ MDQ6R2lzdDAwMmQ2ZW…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2017-06-15 18:06:03 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 7bb2f1cd3d2306209f…  │ MDQ6R2lzdDdiYjJmMW…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2017-01-16 18:48:06 │ Vig README           │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 6738de7fa55b572373…  │ MDQ6R2lzdDY3MzhkZT…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2016-10-25 15:57:18 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ c33cb129af8f2f57cf25 │ MDQ6R2lzdGMzM2NiMT…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2016-01-21 00:51:33 │ Decimal degrees to…  │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ da18482e2b89f4b6ed5f │ MDQ6R2lzdGRhMTg0OD…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2016-01-14 06:20:54 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ f134d6a8c14ed2b0c92f │ MDQ6R2lzdGYxMzRkNm…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2015-08-29 14:10:44 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ d2941c0a6d11c34b828c │ MDQ6R2lzdGQyOTQxYz…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2015-08-29 14:04:54 │ Diffy diff OS X      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ ca2fa6c9f58acd9bec92 │ MDQ6R2lzdGNhMmZhNm…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2015-08-29 14:03:21 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ e1b93463d7bc81eedb5e │ MDQ6R2lzdGUxYjkzND…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2015-08-29 14:02:24 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ f3e5d30dbd3687eddeb0 │ MDQ6R2lzdGYzZTVkMz…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2015-08-29 14:01:00 │ IM A VAMPIRE!        │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 9788368              │ MDQ6R2lzdDk3ODgzNjg= │ https://gist.githu…  │ https://gist.githu…  │ … │ 2015-08-29 13:57:46 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 828efa2fa0e40339024c │ MDQ6R2lzdDgyOGVmYT…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2015-08-29 13:56:58 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ bd6f9317afb952628516 │ MDQ6R2lzdGJkNmY5Mz…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2015-08-29 13:56:53 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 9028074              │ MDQ6R2lzdDkwMjgwNzQ= │ https://gist.githu…  │ https://gist.githu…  │ … │ 2024-11-23 02:39:47 │                      │        2 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 0618a7aa275ebd6bd6bd │ MDQ6R2lzdDA2MThhN2…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2016-01-04 20:59:39 │ pojos por favor      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ ccfda8a27f24afd2e30c │ MDQ6R2lzdGNjZmRhOG…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2016-01-03 09:59:11 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 242aab0fc41a98fd853a │ MDQ6R2lzdDI0MmFhYj…  │ https://gist.githu…  │ https://gist.githu…  │ … │ 2016-01-03 09:28:57 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
│ https://api.github…  │ https://api.github…  │ https://api.github…  │ 7805553              │ MDQ6R2lzdDc4MDU1NTM= │ https://gist.githu…  │ https://gist.githu…  │ … │ 2015-12-30 08:49:16 │                      │        0 │      │ https://api.github…  │ {'login': mando, '…  │ false     │
├──────────────────────┴──────────────────────┴──────────────────────┴──────────────────────┴──────────────────────┴──────────────────────┴──────────────────────┴───┴─────────────────────┴──────────────────────┴──────────┴──────┴──────────────────────┴──────────────────────┴───────────┤
│ 30 rows                                                                                                                                                                                                                                                               18 columns (14 shown) │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
D
```

### How?

I dunno, I toss `duckit` into my `.zshrc` like a sicko, but you could put it somewhere better and `source` it like a good
person. But however you get it into your shell, just `duckit filename` and you're g2g.

---
tags:
  - personalProject
  - AniTunes
---
2024/10/10現在

AniTunesの現状データのディスクスペース使用率
```
+----------+-------------------------------+---------+---------+----------+
| Database | Table                         | Size_MB | Data_MB | Index_MB |
+----------+-------------------------------+---------+---------+----------+
| dev      | _CountryCodeToSpotifyTrack    | 2137.91 | 1145.98 |   991.92 |
| dev      | SpotifyTrack                  |   48.16 |   41.64 |     6.52 |
| dev      | _SpotifyArtistToSpotifyTrack  |   25.13 |   15.58 |     9.55 |
| dev      | _SpotifyAlbumToSpotifyTrack   |   20.13 |   12.58 |     7.55 |
| dev      | AlternativeTitle              |    9.03 |    4.52 |     4.52 |
| dev      | MyAnimeList                   |    6.52 |    6.52 |     0.00 |
```
圧倒的にcountryCodeが多い
やはりcountryCodeはjsonで保管するように変更する価値があると言える
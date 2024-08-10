---
tags:
  - 個人開発
---

ユーザーからはAnilist or MyanimeListのid一覧さえ受け取れば良い
→AnimeThemeAPIからきちんとデータを取得して自前DBを毎日更新していれば最新の曲リストが取得できる

DBコスト削減のため
MediaテーブルとSongテーブルの正規化をせず、一つのテーブルで管理して
AnimeThemeのidを主キーにし、DynamoDBで管理する運用もあり

とりあえずはローカルのsqlでデータベースを構築していく

AnimeThemeAPIに片っ端からリクエストを送ってデータベースを作る
まずはMedia, Song を作る

external_idで指定した場合はMALのresourceまで一回のリクエストでまとめて取得する方法はなさそう

https://api.animethemes.moe/anime?include=animethemes.song.artists,resources&page[size]=100&page[number]=1&filter[has]=resources&filter[resource][site]=AniList,MyAnimeList

これでAniList, MyAnimeListのidを取得可能
---
tags:
  - 個人開発
---
SQLで直接INSERTができたら、アプリケーションの問題
できなければ、SQLについて勉強し直す

animetheme と streamingSong は 1:m ではなく n:m
映像だけ差し替えて別OPとしている場合もあるため
anime と streamingSong はさすがに 1:m ?
歌手が違っても同じ曲、曲名が被っている場合がある
これも n:m で定義すべき

[Song - Non Non Biyori (61690) - AniDB](https://anidb.net/song/61690)
aniDBにofficialなop, edの日本語名が格納されている
udp apiを使えば正確な日本語名が取得可能なので他の音楽APIでの曲取得精度があがる

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
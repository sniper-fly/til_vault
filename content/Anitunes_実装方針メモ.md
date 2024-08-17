---
tags:
  - 個人開発
---
[[AniTunesTodo]]

===================================================
[[2024-08-17]]

spotifyの音楽タイプでalbumを指定しているものがあった
OSTなどでまとめてalbumを指定していることがある

なぜかspotifyTrackを作成時にunique constraint errorに
しかもログが出ない
createdAtから最後に作られようとした物を特定するしかない

そもそも検索結果が同じになってしまう可能性の考慮忘れ
prisma.SpotifyTrack.createは被りに弱いので使えない

===================================================
[[2024-08-16]]
[Get Multiple Catalog Songs by ISRC | Apple Developer Documen...](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_isrc)
ISRCなるものが存在していて、apple musicなどもこれを用いて曲検索ができる
国際的に曲に割り振られる唯一のコード

[ISRC Search](https://isrcsearch.ifpi.org/)
曲名、歌手名からISRCの検索が可能
かつISRCからSpotify APIのsearchが行える
→Aniplaylistを介さなくてもDBを作成できる可能性がある

spotifyは`300*300` の画像を`40*40`にして表示してる

addedTimes はしょっちゅう更新されるとupdatedAtが無意味なカラムになってしまう
hasOneなどで別のテーブルに分離するが吉

spotifyもapple musicもISO 3166 alpha-2に準拠しているので、available_marketテーブルではなくcountry codeテーブルにしてどちらのテーブルでも使えるように

 animate-pulse でスケルトンが表示されている場合、その子要素が何かを表示するまでずっと待ってしまう
animate-pulse クラスを持っている子要素はこのクラスを発見次第それ以上探索しないようにしたい

また、スクロールイベントを使って何回かスクロールして要素が全て表示しきれたことを確認してから探索する、など

検索クエリに
?types=Ending
などをつけると精度があがる

===================================================
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
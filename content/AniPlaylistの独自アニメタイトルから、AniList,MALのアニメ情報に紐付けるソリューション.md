---
tags:
  - 個人開発
---
[[2024-09-18]]
APSongを1件ずつ走査
紐づくAPAnimeTitleがN個あるとする。
MyAnimeListのtitle, AlternativeTitleのtitleに対して完全一致するAPAnimeTitleが最も多いアニメを見つけられればAPSongとMAL、AniListとの関連を定義できそう
これを探すSQLを定義して、例外を探す
逆に、タイトル完全一致するアニメが見つからないAPSongを見つけ出す
これによってさらにSQLを改善する

===========================================
AniPlaylistの独自アニメタイトルから、AniList,MALのアニメ情報に紐付けるソリューション

結論：Braveを使ってウェブ検索で曖昧ワードを絞り込む

Attack on Titan: The Final Season Part 3
AnilistもMALもこの表記ではない
キャプテン翼などの表記は大体一致する
大体一致しているかどうか？の判定にウェブ検索を利用するアイデア
完全一致の場合は不要だが、一致するタイトルが見つからない場合がある
https://search.brave.com/search?q=Attack+on+Titan%3A+The+Final+Season+Part+3+site%3Amyanimelist.net%2F&source=web
braveで、myanimelistに限定して検索する
ここからMALのidが絞り込める場合がある
https://search.brave.com/search?q=Attack+on+Titan+site%3Amyanimelist.net%2Fanime&source=web
`site:myanimelist.net/anime`のようにルートを絞り込んで検索も可能
ここの上位5件ぐらいのidを取得すれば、animetheme dbと結びつけることができ、
そこから曲名の完全一致検索ができれば（OP,EDに限る）かなり高い精度でアニメを絞ることができる
曲名の完全一致検索ができなくとも、ウェブ検索結果上位5件のアニメと紐づけてしまえばそこまで間違いは起きないはず

[[文字列の類似度を測る方法]]
こちらにもさまざまな文字列類似度を測る方法がある
曲名の完全一致検索が難しい場合もこういった手法が使える可能性がある
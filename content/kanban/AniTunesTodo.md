---

kanban-plugin: board

---

## Planning

- [ ] アニメ名 ＋ 曲名 検索ではなくアニメ名検索にしてリクエスト数を減らす
- [ ] albumデータをspotifyで検索して正しくtracksを作成できるようにする


## In Progress

- [ ] bandwidthの削減
- [ ] playwrightが本当にリクエストごとにIPを変えているかテスト
- [ ] APAnimeTitleテーブル作成


## Complete

- [ ] DB構造の大規模変更（Anime hasMany APSong, APSong hasOne SpotifyTrack ,,,）
- [ ] 無限スクロールの対応
- [ ] リクエスト毎 or timeoutで失敗した時に別プロキシに切り替えるようにする
- [ ] timeout発生時にスクショを撮る
- [ ] fetchに失敗したアニメタイトルから自動的にスクレイピングを再開できるようにする
- [ ] spotifyAPIから必要な情報を取り出してDBに保存
- [ ] spotifyAPIとの通信
- [ ] 固定長カラムの文字数制限（容量節約のため）文字列のIDなど特に
- [ ] 検索クエリにOPやEDを入れて精度を上げる
- [ ] 検索結果が多い場合にスクロールする
- [ ] urlからspotify uriを取り出す関数を作る
- [ ] AniplaylistでsongTypeを取得


## archive

- [ ] anime has many SpotifyTrackのみに限定して、animeThemeとSpotifyTrackの関連はwhereでの一致検索とする
- [ ] lambda nginx forward proxy
- [ ] SpotifyTrackのname index追加
- [ ] ISRCによる他音楽DBとの結合




%% kanban:settings
```
{"kanban-plugin":"board","list-collapse":[false,false,false,false]}
```
%%
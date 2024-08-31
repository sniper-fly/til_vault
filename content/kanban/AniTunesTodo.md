---

kanban-plugin: board

---

## Planning

- [ ] AIkaでheadless falseにしてリトライ処理が上手く動いているか調査
- [ ] ERR_TUNNEL_CONNECTION_FAILED時に接続IPをロギング
- [ ] APに追加された曲をAnimeテーブルに自動ヒモ付
- [ ] AnimeThemeAPIのupdateを自動更新して反映させる


## In Progress

- [ ] saveAPsongからspotifyfetch関連を分離する
- [ ] まずDBに検索をかけて既に存在する楽曲情報に関して不要なfetchをしないようにする


## Complete

- [ ] 他のAPSongと紐付いていた場合にAPSongとAnimeのヒモ付が更新されない
- [ ] waitForInfiniteScrollの無限ロック対策
- [ ] 格納可能文字列サイズの調整
- [ ] savetrack失敗時のログが出ない問題
- [ ] 無限スクロールの検知精度改善
- [ ] typescriptのlogger導入
	winstonでファイル出力
- [ ] saveAPsongもSpotifyAPIのrate limitがあるのでリトライ機構を仕込む
- [ ] myanimelistのタイトルを使ってAPを検索
- [ ] timeoutした際に数秒時間をおいて3回までリトライする
- [ ] MALのデータ収集
	MALテーブルを作成
- [ ] アニメ名 ＋ 曲名 検索ではなくアニメ名検索にしてリクエスト数を減らす
- [ ] saveSpotifyTrackなどの作り直し：APSongデータとの関連付け
	createAPSong関数の作成
- [ ] albumデータをspotifyで検索して正しくtracksを作成できるようにする
- [ ] encodeSearchQueryの改修
- [ ] scrapeUrlsがAPでのアニメタイトルや曲のタイトルを取得できるように改良
- [ ] playwrightが本当にリクエストごとにIPを変えているかテスト
- [ ] bandwidthの削減
- [ ] APAnimeTitleテーブル作成
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

- [ ] saveAPsongの戻り値にAPsongを指定して、selectNew関数に渡すことができるようにして同期関数化する
- [ ] 大量検索結果に対応するため、スクロール即データインプットを実現する
- [ ] scroll, waitforskeltonのtimeoutの決め打ちをやめてresultの数に比例するようにする
- [ ] anime has many SpotifyTrackのみに限定して、animeThemeとSpotifyTrackの関連はwhereでの一致検索とする
- [ ] lambda nginx forward proxy
- [ ] SpotifyTrackのname index追加
- [ ] ISRCによる他音楽DBとの結合




%% kanban:settings
```
{"kanban-plugin":"board","list-collapse":[false,false,false,false]}
```
%%
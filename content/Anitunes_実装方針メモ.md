---
tags:
  - 個人開発
---
[[AniTunesTodo]]

===================================================
[[2024-09-02]]

album:track = 7:32 ~= 1:4
limit 7000
total 21860
track 16000
320回
album 5000
250回

残りアニメ 4000
そもそもAPsongのjsonさえ取得できれば、spotifyのAPIを呼び出すのはその後でも良い
スクレイピング時はAPsongの作成のみを行い、取得したjsonを保存してあとでまとめて分別してSpotifyのTrack, Album, AppleMusicUrlのデータ作成を行う

SongsInfoCombinedにjsonのsetを集め、forループ終了毎にファイルに書き込む
その際に `export combined = ` を足すことで、parse再開時にそのままtsファイルとしてimport出来るようにする

===================================================
[[2024-09-01]]

`api.track.get(strings[])` を使うのは面倒なので諦める
高速化の妥協案として、selectExistingSongIds 関数を作成して、
新たにfetchする必要のないレコードを検出できるようにした

これで同じspotifyTrackに対して何回もfetchが走ることはない
ただし、検出メカニズムはspotifyに対して最適化されているわけではない

===================================================
[[2024-08-30]]

AppleURLが空
SpotifyURLがある && SpotifyTrackがある スキップ
SpotifyURLが空 && AppleUrlが存在する →スキップ
spotifyurlが空 && 存在しない はどちらでもない（applemusicを見るまで確定しない）
urlがある && 存在しない はスキップしない
urlがある && 存在する はスキップ

```ts
    const spotifyUri = extractSpotifyUri(song.spotifyUri);
    const spotifyTrackExist =
      spotifyUri &&
      song.type === "track" &&
      (await prisma.spotifyTrack.findUnique({
        where: { id: spotifyUri },
      }));
    const spotifyAlbumExist =
      spotifyUri &&
      song.type === "album" &&
      (await prisma.spotifyAlbum.findUnique({
        where: { id: spotifyUri },
      }));

    const appleMusicUrl = extractAppleMusicUri(song.appleMusicUrl);
    const appleMusicExist =
      appleMusicUrl &&
      (await prisma.appleMusicUrl.findFirst({
        where: { url: appleMusicUrl },
      }));

    if (spotifyTrackExist) console.log("spotifyTrackExist");
    if (appleMusicExist) console.log("appleMusicExist");

    if (!(spotifyTrackExist || spotifyAlbumExist) || !appleMusicExist) {
      newSongs.push(song);
    }
```

===================================================
[[2024-08-29]]
MALは無理でもAniListならupdatedAt順に情報が取得できる
AniListからMALのidを取得できれば、実質的にタイトルの自動更新が出来る

[Downloads | The Logfile Navigator](https://lnav.org/downloads)
lnavというコマンドラインツールがログ監視でやりやすそう

なぜかTrackの情報がログに表示されない

スクロール数が多くなると、画像表示とかの関係なのか
画面の長さが伸長して最下段の要素が下方向にズレてしまう

void型とは何なのか？

upsertでconnectだけupdateした場合に、
今までの関連が消えた上で更新されるのか、追加されるのか検証が必要

waitForInfiniteScrollの無限ロック対応

===================================================
[[2024-08-28]]

そもそもalternative_titleは本当にja, en だけ？
他の言語のはいらないのでこれで十分

長過ぎるタイトルに関する調査スクリプトを供養
```ts
async function surveyTooLongTitle(anime: MalResponse["data"][number]) {
  if (anime.node.title.length >= 191) {
    console.log("title: ", anime.node.title);
  }
  const altTitles = anime.node.alternative_titles;
  if (altTitles) {
    for (const title of altTitles.synonyms || []) {
      if (title.length >= 191) {
        console.log("id:", anime.node.id, "synonym title: ", title);
      }
    }
    if (altTitles.en && altTitles.en.length >= 191) {
      console.log("id:", anime.node.id, "en title: ", altTitles.en);
    }
    if (altTitles.ja && altTitles.ja.length >= 191) {
      console.log("id:", anime.node.id, "ja title: ", altTitles.ja);
    }
  }
}

async function surveyNotExistTitle(anime: MalResponse["data"][number]) {
  const altTitles = anime.node.alternative_titles;
  if (altTitles) {
    for (const title of altTitles.synonyms || []) {
      const a = await prisma.alternativeTitle.findFirst({
        where: { title },
      });
      if (!a) {
        console.log("not exist: ", title, anime.node.id);
      }
    }
    if (altTitles.en && altTitles.en.length >= 191) {
      const a = await prisma.alternativeTitle.findFirst({
        where: { title: altTitles.en },
      });
      if (!a) {
        console.log("not exist: ", altTitles.en, anime.node.id);
      }
    }
    if (altTitles.ja && altTitles.ja.length >= 191) {
      const a = await prisma.alternativeTitle.findFirst({
        where: { title: altTitles.ja },
      });
      if (!a) {
        console.log("not exist: ", altTitles.ja, anime.node.id);
      }
    }
  }
}
```

===================================================
[[2024-08-27]]

Anilistのidを指定して逐一検索するのではなく、
タイトル情報とidだけ抜き出して全アニメの情報をまとめて100件ずつ取れば必要なリクエストの回数はおよそ1/100になる
後々でAnimeThemeAPIの情報と紐付ければ良い

MALとAniListだと、表記ゆれしがちなアニメでMALのタイトルが一致することが多いので、こちらを採用したい

[GitHub - mist8kengas/mal-ts: TypeScript-safe MyAnimeList Pub...](https://github.com/mist8kengas/mal-ts)
プロキシを挿せるのかどうか

axiosで普通にプロキシ経由でAPIリクエストが呼べるかをまず試して、ライブラリの更新を試みる
そもそもプロキシを経由したところで、ユーザーの認証が必要ならば意味がない可能性がある

MALのAPIはIDを羅列する用途には使いづらそう
何らかの検索クエリが必要＆短いクエリでは検索できない
全てのアニメを羅列する手段がない
→rankingを使えば可能
27109位が最下位
AnimeThemeAPIにあるアニメ総数が4371とすると実に7倍ほど

クエリ回数は272回で済む

===================================================
[[2024-08-26]]

まずはマイグレーション

ページ描画よりAPIの方が通知が速いからsentinelが0だったりする？

sentinelがある限り、スクロールする
responseが来るタイミングと画面描画のタイミングがズレる
responseが来るタイミングの方が速いため、
最後のレスポンスが来ているのにsentinelが存在する場合がある

画面描画を規準に待たないといけない
- 現時点で存在しない要素が出てくるまで待つ
- songsの数が増えるまで待つ

waitForLoadStateでは最初の読み込みまでは待てるが、逐次的な更新を待つのは難しい
```ts
  await page.waitForLoadState("domcontentloaded");
```

セレクタを一生懸命探してHTMLを解析してデータを抜き取っているスクレイピングの様子を供養
```ts
async function getAniPlaylistSongInfo(items: Locator[]) {
  return Promise.all(
    items.map(async (item) => {
      const songType = await item
        .locator("span.hidden.xl\\:inline-block")
        .innerText();
      const animeTitle = await item
        .locator("h3.hidden.font-medium")
        .innerText();
      const songTitle = await item.locator("span.break-words").innerText();
      const result: AniPlaylistSongInfo = { songType, animeTitle, songTitle };

      if ((await item.locator("a[href*='open.spotify.com']").count()) > 0) {
        const spotifyUrl = await item
          .locator("a[href*='open.spotify.com']")
          .getAttribute("href");
        result["spotifyUrl"] = spotifyUrl!;
      }
      if ((await item.locator("a[href*='music.apple.com']").count()) > 0) {
        const appleMusicUrl = await item
          .locator("a[href*='music.apple.com']")
          .getAttribute("href");
        // result["appleMusicUrl"] = appleMusicUrl!;
      }
      return result;
    })
  );
}
```

APIで取ってきたデータが画面描画に使われるまで待つ方法でピッタリ待つことに成功
```ts
    const res = await page.waitForResponse(
      (response) =>
        response.url().includes("p4b7ht5p18") && response.status() === 200
    );
    // 通信で取得したjsonの要素が表示されるまで待つ
    const json: APsongJson = await res.json();
    const link = json.results[0].hits[0].links[0].link;
    await page.locator(`a[href="${link}"]`).waitFor();
```

===================================================
[[2024-08-25]]

APIのレスポンスを使えば、超シンプルに実装可能かも
しかも曲ごとに割り振られている隠れIDも利用可能
紐付けられているアニメのタイトルも複数取得可能
表記ゆれ対応にも光明が見える

問題は、何回リクエストが来るかわからない
検索結果が十分に多ければ3回
16個以内なら2回
0個なら1回

waitForResponseを仕掛けておくと、来ないリクエストを待ってしまってブロッキングしてしまう可能性がある

方略：
主スレッド
div.sentinelがある場合その場所にスクロールする

並行処理

最初
waitForResponseで待つ

[Customize the field names of join table in implicit many-to-...](https://github.com/prisma/prisma/issues/22933)
implicit many to many relationで作成されるキーの名前は編集できない
逆に言うとこれを編集する機能はPRを上げられるということ

===================================================
[[2024-08-24]]

検索結果数の取得

div.sentinelが無限ローディングを司っている

fa fa-spinner fa-pulse fa-fw fa-3x

読み込みを終わっていい条件
→div.sentinelが存在しない＆＆div.animate-pulseが存在しない

![[Screenshot from 2024-08-24 17-15-52.png]]

プロキシの場合に送られてくるjs query のurl
https://p4b7ht5p18-3.algolianet.com/1/indexes/*/queries?x-algolia-agent=Algolia%20for%20JavaScript%20(4.17.0)%3B%20Browser%20(lite)&x-algolia-api-key=cd90c9c918df8b42327310ade1f599bd&x-algolia-application-id=P4B7HT5P18

自分のpcからだと以下のようになる
https://p4b7ht5p18-dsn.algolia.net/

そもそもAPIを呼んだ時点で実はほとんどデータが読み込めていて、
animate-pulseはブラウザの表示を軽くするために設けられたストッパーだとしたら？
→div.sentinelを追いかけ、APIのレスポンスを待つだけで、
セレクタなども不要で全てのデータを得られるのでは？

===================================================
[[2024-08-23]]

https://api.spotify.com/v1/albums/0gB3AKAUJHTWqUzxdqXDxg/tracks?offset=0&limit=50
albums/{id}/tracks エンドポイントでなぜかavailable_marketsが表示されない
APIのバグ
仕方ないので、集めたtracksのidを使って
/tracks エンドポイントでまとめてリクエストして情報を得るしかない

albumの中に、既に追加したtrackが入っていたらどうする？

検索結果が非常に多い場合、無限スクロールの解消は簡単だが、
ローディングスケルトンを消す作業が非常に難しい
上から順にスクロールしてロードしていっても、ページ上部のスケルトン表示がまた復活してしまうので無限ループになる
解決策２つ

- スクロールでのページ読み込み、DBデータ作成を並行して行う
これはリーダブルコードではロジックの断片化としてバッドプラクティスになっている

- スクロールでのページ読み込みを改善して、スクロール即データインプットを繰り返す
最初に無限スクロールで全項目を表示したら、apsong要素一つ一つに上から番号をつける

index 0 ~ 最初のanimate-pulseが付いている要素までapsongをスクレイピング
最初のanimate-pulseまでスクロールして移動
animate-pulseがついている要素を再度取得。
現在のindexより大きい要素でかつanimate-pulseがついている要素までapsongをスクレイピング
そのanimate-pulseまでスクロールして移動
...
こんな感じの処理を繰り返してページのしたまでたどり着き、全てスクレイピングできれば成功

もしくはもっと単純に1ページ表示単位毎にスクロールして、
大体曲10個分下の要素までスクロール、そこまでの曲をスクレイピングする
とかでも良い

===================================================
[[2024-08-19]]

→例えばOpening, Ending, などクエリ毎に集計するなどで検索結果を減らして安定させる
これだと1アニメあたりのリクエスト回数が10回とかになって逆にリクエスト数が増えてしまう

最初に一番下の画面までスクロールして、それからanimate-pulseを1個1個潰していく

後々アニメタイトルや曲名一致に使うため、aniplaylistでのアニメタイトル表示、
英語での曲名表示もスクレイピングしておく

APSongを作る場合にidどうするか問題
スクレイピング途中で作成に失敗した場合、リトライが発生する
SpotifyTrackは必ず一つのAPSongと対応するので、再作成時にも同じAPSongに対応するようにしなければならない

AniPlaylist側に各曲を識別する内部idが存在しないか？
このようにアニメタイトル+anime typeで個別の曲のURLを構成していることから、
これがidになりそう
https://aniplaylist.com/play/toriko-ed-9?source=moreinfo
共有リンクから取得可能

やはりAPAnimeTitleは別テーブルに切り出すべき
アニメ名の一括変更に対応できない

===================================================
[[2024-08-18]]

現状の課題としては、
- 沢山リクエストを送ると50回目ぐらいでデータが表示されなくなる
- プロキシの制限超過

解決策としては以下
- プロキシの切り替え
→リクエスト毎にブラウザを変えるか？失敗したらブラウザを変えるか？
失敗の判定が面倒。ただ完全放置でデータ作成ができるようにするためには結局リトライ部分の実装が必要になってくる

- AniPlaylistへのリクエスト数削減
→アニメ名検索のみにして、AnimeTheme hasMany SpotifyTracks 関連を削除
→曲名の一致検索、部分一致検索のみでOP,EDの一致を保証してプレイリスト作成を行う

どっちにしろアニメ名検索でinsert songとかの追加も行いたいから、
これのほうが一貫性があって良い

これにあたって
- 一回の検索結果で表示される曲数が多いため、安定してスクレイピングするのが難しい
→例えばOpening, Ending, などクエリ毎に集計するなどで検索結果を減らして安定させる

- 検索結果が十分に絞れないため、別のアニメの結果が混ざってしまう
→のちのち精度を向上させ、例えば続編の情報をAnimeに追加して続編の曲を含めないようにするなどで段々精度をあげていくしかない
スクレイピングする際に、aniplaylistにアニメタイトルが載っているので、これの一致検索などが後々できそうではある

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
---
tags:
  - typescript
---

typescript, finally文の具体的な使いどころ（エラー時のリトライ処理）

[try-catch のfinallyっていつ使うねん、ていう話 #JavaScript - Qiita](https://qiita.com/musenmai/items/c6e7af3dd57f0f88db9c)

スクレイピングではネットワークの異常、IPのブロックなどエラーがつきもの。
寝ている間にスクレイピングしているようなとき、
エラーが発生した時でもしばらく待って処理を続行してほしかったりする。

```ts
    const page = await initPage(browser);
    const context = page.context();
// 失敗する可能性がある処理
    await page.goto(url);
    songsInfo = await scrollToReadApiRes(page);
//
	await context.close();
	await page.close();
```
成功時も、失敗時も一度pageを閉じてやり直したい。
そこでfor文内でtry, catchを使い、失敗時のリトライ処理を書くと、
```ts
export async function scrapeAniPlaylist(browser: Browser, url: string) {
  let songsInfo: AniPlaylistSongMap = {};
  // 失敗した場合は時間をおいて3回までリトライ
  const maxRetry = 3;
  for (let i = 0; i < maxRetry; i++) {
    const page = await initPage(browser);
    const context = page.context();
    try {
      await page.goto(url);
      songsInfo = await scrollToReadApiRes(page);
      await context.close();
      await page.close();
      break;
    } catch (e) {
      await context.close();
      await page.close();
      console.error(e);
      console.log("retry");
    }
  }
  return songsInfo;
}
```
実に冗長である。
しかし、例えば以下のように書くと成功したときも失敗したときもbreakしてしまうので、retryできない
```ts
  for (let i = 0; i < maxRetry; i++) {
    const page = await initPage(browser);
    const context = page.context();
    try {
      await page.goto(url);
      songsInfo = await scrollToReadApiRes(page);
    } catch (e) {
      console.error(e);
      console.log("retry");
    }
    await context.close();
    await page.close();
	break
  }
```

そこでfinallyを使う。
これなら、成功時にbreakでfor文を抜けたとしてもfinallyは実行されるし、
catchブロックの中に入ったとしても、必ずfinallyは実行される。
```ts
export async function scrapeAniPlaylist(browser: Browser, url: string) {
  let songsInfo: AniPlaylistSongMap = {};
  // 失敗した場合は時間をおいて3回までリトライ
  const maxRetry = 3;
  for (let i = 0; i < maxRetry; i++) {
    const page = await initPage(browser);
    const context = page.context();
    try {
      await page.goto(url);
      songsInfo = await scrollToReadApiRes(page);
      break;
    } catch (e) {
      if (i === maxRetry - 1) throw e;
      console.error(e);
      console.log("retry");
      await wait(60000 + 300000 * i); // リトライ回数に応じて待機時間を増やす
    } finally {
      await context.close();
      await page.close();
    }
  }
  return songsInfo;
}
```
オブジェクト指向でいうところのデストラクタの役割に近しいものがある。
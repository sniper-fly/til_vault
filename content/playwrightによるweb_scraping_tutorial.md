---
tags:
  - tutorial
  - playwright
  - typescript
---
playwrightによるweb_scraping_tutorial
スクレイピングの詳細なチュートリアルがある
[Playwright Scraping Tutorial (2024)](https://oxylabs.io/blog/playwright-web-scraping)
プロキシの設定まで

webshareのproxy利用
ちゃんとポート番号まで入れないと接続できない
```
server: `http://${process.env.address}:${process.env.port}`,
```

```ts
  //  css-1p1xtrz クラスが付与されたボタンを押す
  await page.locator("button.css-1p1xtrz").click();
```
指定したセレクタのボタンを押すことができる

```ts
  const urls = await page.$$eval("ais-InfiniteHits a[href*='open.spotify.com']", (elements) => {
```
このセレクタでなぜが値が取得できない


モックブラウザをそのまま起動して開発者ツールを使うにはどうすれば？
```ts
  await browser.close();
```
上記の表示をコメントアウトすれば良い
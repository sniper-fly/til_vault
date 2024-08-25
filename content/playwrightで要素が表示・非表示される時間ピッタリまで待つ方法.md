---
tags:
  - playwright
  - typescript
---
```ts
  await page.waitForTimeout(2000);
```
こういった決め打ちの待ち時間をなくしたい

特定のセレクタが表示されるまで待つには、以下の方法がある
```ts
  // Wait for any Spotify link to appear
  await page.waitForSelector("a[href*='open.spotify.com']");
```

[Page | Playwright](https://playwright.dev/docs/api/class-page#page-wait-for-selector)
但し、上記の公式ページでは非推奨
locatorを使う方法が推奨されている

locatorはplaywrightのコアコンセプトで、自動で要素の表示を待ってくれたりする

https://playwright.dev/docs/api/class-page#page-locator
```ts
page.locator(selector);
// 戻り値はLocator

page.locator(selector).all();
// selectorに合致する全てのLocator配列のPromiseを返す

// 実用例 getAttributeはPromiseを返すので、Promise.allが必要
  const linkTags = await page.locator("a[href*='open.spotify.com']").all();
  const urls = await Promise.all(
    linkTags.map((linkTag) => linkTag.getAttribute("href"))
  );
```

[Locator | Playwright](https://playwright.dev/docs/api/class-locator)

[playwrightで要素を選択する方法5種類とその挙動の違い #JavaScript - Qiita](https://qiita.com/ko-he-8/items/85116e1d99ed4b176657)
ただし、locator.allは要素が表示されるまで待ってくれるわけではなく、
画面にあるものを即座に返してしまうそうなので、waitForSelector もしくはwaitForを使うべき

waitFor はデフォルトで 'visible' stateになるまで待つ
`page.locator("a[href*='open.spotify.com']").waitFor();`
と書いてしまうと、セレクタに一致する要素が複数あるときにエラーになる
```ts
async function hasResult(page: Page) {
  const notFound = (async () => {
    await page.getByText("0 result found").waitFor({ timeout: 10000 });
    return false;
  })();
  const spotifyFound = (async () => {
    await page.locator("a[href*='open.spotify.com']").first().waitFor();
    return true;
  })();
  const appleMusicFound = (async () => {
    await page.locator("a[href*='music.apple.com']").first().waitFor();
    return true;
  })();
  return Promise.race([notFound, spotifyFound, appleMusicFound]);
}
```

逆に、要素がDOMから存在しなくなるまで待つには？ 'detached' が使える
これで一応animate-pulseが存在しなくなるまで待つことができた
```ts
  // ローディングが終わるまで待機
  await items[delta]
    .locator("div.animate-pulse")
    .first()
    .waitFor({ state: "detached" });
```
[How can I wait for elements to disappear completely from a page? | Reddit](https://www.reddit.com/r/Playwright/comments/1dl58ap/how_can_i_wait_for_elements_to_disappear/)

playwrightのstateに関する話は↓ にも
[[playwrightで、指定したセレクタの要素が存在していない場合にtrueを返すには？]]
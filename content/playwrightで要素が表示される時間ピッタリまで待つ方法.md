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
画面にあるものを即座に返してしまうそうなので、waitForSelectorを使うべきとのこと、
ホントか？

今のところはなくても動作している
waitforselectorがあると、検索結果がないときに無限に待ち続けてしまう
今の所locator.allが一番いい感じに動く

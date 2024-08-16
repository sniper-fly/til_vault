---
tags:
  - typescript
  - playwright
---
[\[Question\] What does it mean Error: strict mode violation ...](https://github.com/microsoft/playwright/issues/10611)
https://playwright.dev/docs/locators#works-fine-with-multiple-elements
waitFor, clickなど、locatorが複数の要素を特定する時、エラーになってしまう
nth(), first(), last() などを使って１個の要素を見つけるようにしないとダメなメソッドがある

例えばカード一覧が画面に存在して、その子要素一つ一つに対して何かデータを取得したい場合
まずitemsで親要素を特定し、直接の子全てを選択するセレクタを指定
子要素の数を数え、locator のnthメソッドを使って一つ一つに対して処理を実行できる
[nth() | Locator | Playwright](https://playwright.dev/docs/api/class-locator#locator-nth)
```ts
  await page.goto(baseUrl + "my-hero-academia");
  const items = page.locator("div.grid.grid-cols-1"); // 検索結果カードの親要素
  const children = items.locator("> *"); // 直接の子要素を取得
  const count = await children.count();

  for (let i = 0; i < count; i++) {
    const item = children.nth(i);
    const url = await item
      .locator("a[href*='open.spotify.com']")
      .getAttribute("href");
    const songType = await item.locator("span.hidden.xl\\:inline-block").innerText();
    console.log("====================================");
    console.log(url);
    console.log(songType);
  }
```

また、`:`コロン などがクラス名に含まれている場合はエスケープが必要
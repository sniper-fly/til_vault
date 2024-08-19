---
tags:
  - playwright
  - typescript
---
[\[Question\] What is the best way to scroll page to the bott...](https://github.com/microsoft/playwright/issues/4302)
こちらにも色々

playwrightによるスクロールの対応

`Playwright`でスクロールするには、いくつかの方法があります。特定の要素までスクロールしたり、ページ全体をスクロールしたりすることができます。以下に、代表的な方法を紹介します。

### 1. 要素までスクロール
特定の要素が表示されるまでスクロールするには、`scrollIntoViewIfNeeded` メソッドを使います。
[scrollIntoViewIfNeeded | Locator | Playwright](https://playwright.dev/docs/api/class-locator#locator-scroll-into-view-if-needed)
```ts
// 特定の要素までスクロール
await page.locator('your-selector').scrollIntoViewIfNeeded();
```
このメソッドは、特定の要素のlocatorの場所までスクロールします。

### 2. ページ全体をスクロール
ページ全体をスクロールするには、JavaScriptを使ってスクロールアクションを実行します。

```ts
// 下方向にスクロール
await page.evaluate(() => window.scrollBy(0, window.innerHeight));

// 上方向にスクロール
await page.evaluate(() => window.scrollBy(0, -window.innerHeight));
```

### 3. ページの一番下までスクロール
ページの一番下までスクロールする場合は、以下のようにします。
```ts
await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
```

### 4. スクロールを使った無限スクロールの対応
無限スクロールがあるページで、すべてのコンテンツを読み込むためにスクロールを繰り返すこともできます。

```ts
while (true) {
    const previousHeight = await page.evaluate('document.body.scrollHeight');
    await page.evaluate('window.scrollTo(0, document.body.scrollHeight)');
    await page.waitForTimeout(2000); // スクロール後に少し待機
    const newHeight = await page.evaluate('document.body.scrollHeight');
    if (newHeight === previousHeight) {
        break; // スクロールしても高さが変わらなくなったら終了
    }
}
```

### 5. 特定の座標までスクロール

ページの特定の位置までスクロールすることもできます。
```ts
await page.evaluate(() => window.scrollTo(0, 500)); // y座標500pxまでスクロール
```

これらの方法を使うことで、`Playwright`で様々なスクロール操作を実行できます。目的に応じて最適な方法を選んでください。
---
tags:
  - playwright
---
playwrightでrouteを使って不要なjsフェッチをしないようにして通信量を削減する
[how to use route | Page | Playwright](https://playwright.dev/docs/api/class-page#page-route)
```ts
const page = await browser.newPage();
await page.route('**/*.{png,jpg,jpeg}', route => route.abort());
await page.goto('https://example.com');
await browser.close();
```
上記の使い方で適当なpngファイルなどのfetchをキャンセルできる

通したいリクエストだけをcontinueで通して、通したくないものをabortする手もある
```ts
  const page = await browser.newPage();
  await page.route(/.js.*/, (route) => {
    const url = route.request().url();
    if (url.match(/aniplaylist\.com\/js\/public\.js/)) {
      return route.continue();
    }
    return route.abort();
  });
`
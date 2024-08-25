---
tags:
  - playwright
---
![[Screenshot from 2024-08-25 11-30-45.png]]
Playwrightでブラウザが特定のAPIからのレスポンスが返ってくるまでドンピシャで待つ

例えば上記のようなリクエストに絞ってwaitしたい場合
```ts
  const response = await page.waitForResponse(
    (response) =>
      response.url().includes("p4b7ht5p18") &&
      response.status() === 200
  );
```

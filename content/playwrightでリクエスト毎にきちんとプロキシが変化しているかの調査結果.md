---
tags:
  - playwright
---
playwrightでリクエスト毎にきちんとプロキシが変化しているかの調査結果
```ts
  const browser = await chromium.launch({
    headless: false,
    proxy: {
      server: `http://${process.env.PROXY_ADDRESS}:${process.env.PROXY_PORT}`,
      username: process.env.PROXY_USER,
      password: process.env.PROXY_PASS,
    },
    args: ["--blink-settings=imagesEnabled=false", "--disable-remote-fonts"],
  });

  const page = await browser.newPage();
  const response = await page.goto("https://httpbin.org/ip");
  if (!response) return;

  console.log(await response.json());
```

IPを自動変更するプロキシでのplaywrightの挙動について

pageをcloseしないバージョン
```ts
  const page = await browser.newPage();
  for (let i = 0; i < 2; i++) {
    const response = await page.goto("https://httpbin.org/ip");
    if (!response) return;
    console.log(await response.json());
    await page.waitForTimeout(1000);
  }
```
結果
```
{ origin: '45.127.248.127' }
{ origin: '45.127.248.127' }
```
時間をおいても、同じIPで接続しようとする

pageをcloseするバージョン
```ts
  for (let i = 0; i < 2; i++) {
    const page = await browser.newPage();
    const response = await page.goto("https://httpbin.org/ip");
    if (!response) return;
    console.log(await response.json());
    await page.waitForTimeout(1000);
    await page.close();
  }
```
結果
別のIPで接続しようとする
```
{ origin: '173.0.9.70' }
{ origin: '206.41.172.74' }
```

rotating address を活かす場合はpageをいちいちcloseしないとダメ
```
{ origin: '173.0.9.209' }
{ origin: '173.0.9.70' }
```
ちなみにwaitForTimeoutをおかないと、近いアドレスを指定される模様
---
tags:
  - typescript/promise
---

#### Promise.raceで、自前の関数を定義してどちらが先に返ってきたかを正確に判定する方法
Promise.race は、渡されたプロミスの中で最初に解決されたものを返しますが、そのプロミスの結果が何であったかを判定するために、プロミスをカスタムのラッパー関数で包む必要があります。

以下のコードでは、notFound と found のどちらが先に解決されたかを判定するために、それぞれのプロミスにラベルを付けています。

```ts
const notFoundPromise = (async () => {
    await page.getByText("0 result found").waitFor();
    return { result: 'notFound' };
})();

const foundPromise = (async () => {
    await page.waitForSelector("a[href*='open.spotify.com']");
    return { result: 'found' };
})();

const res = await Promise.race([notFoundPromise, foundPromise]);

if (res.result === 'notFound') {
    console.log("0 result found が先に見つかりました");
} else if (res.result === 'found') {
    console.log("Spotify のリンクが先に見つかりました");
}
```

### 説明
1. `notFoundPromise` と `foundPromise` の両方を `async` 関数として定義し、それぞれの操作が完了した際に、カスタムのオブジェクト `{ result: 'notFound' }` または `{ result: 'found' }` を返します。
2. `Promise.race` で両方のプロミスを競争させ、最初に解決されたプロミスの結果 (`res`) を得ます。
3. `res.result` の値を確認することで、どちらのプロミスが先に解決されたかを判定できます。
この方法で、どちらの条件が先に満たされたかを正確に判定できます。

自作のplaywright関数ではこう活かす
```ts
  const notFound = (async () => {
    await page.getByText("0 result found").waitFor();
    return "not found";
  })();
  const found = page.waitForSelector("a[href*='open.spotify.com']");

  const res = await Promise.race([notFound, found]);
  if (typeof res == "string" && res === "not found") console.log("not found");
```
---
tags:
  - typescript
---

Promiseの外からリゾルバを呼ぶ
以下のような形で、terminateFlag をPromiseで定義して、非同期で処理を行うsomeFunctionに引数として渡します。
```ts
  const terminateFlag = new Promise((resolve) => {
    ...
  });

  // 非同期で処理が実行される
  someFunction(terminateFlag);

  await terminateFlag;
```
someFunction内で、terminateFlagのresolveを呼べるようにしたいです。
どのように書けば良いでしょうか？

外の変数にresolverを渡す
```ts
let terminateResolve: () => void;

const terminateFlag = new Promise<void>((resolve) => {
  terminateResolve = resolve;  // resolve関数をterminateResolveに格納
});

// 非同期で処理が実行される
someFunction(terminateFlag, terminateResolve);

await terminateFlag;
```
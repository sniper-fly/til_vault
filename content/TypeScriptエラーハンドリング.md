---
tags:
  - typescript
---

TypeScriptエラーハンドリング
[TypeScript のエラーハンドリングを考える #TypeScript - Qiita](https://qiita.com/frozenbonito/items/e708dfb3ab7c1fd3824d)
try catch でcatchにエラーのクラスを指定したりすることはできないので、下記のようにして対応する
```ts
try {
  // 例外を throw する処理
  foo();
} catch (e: unknown) {
  if (e instanceof ErrorX) {
    // ErrorX のハンドリング
    // ...
  } else if (e instanceof ErrorY) {
    // ErrorY のハンドリング
    // ...
  } else {
    // ...
  }
}
```
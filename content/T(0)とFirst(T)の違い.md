---
tags:
  - typescript
  - type-challenge
---
`T[0]` と `First<T>` の違い
```ts

T = [] のとき T[0] はundefined
First<T> は never

// undefinedがTの中に含まれているかを検査したい時、T[0]は好ましくない
// neverは値がないことを表す
```
[never型 | TypeScript入門『サバイバルTypeScript』](https://typescriptbook.jp/reference/statements/never)

https://github.com/type-challenges/type-challenges/issues/1568
include 問題でこの違いが認識されているかどうか重要になった
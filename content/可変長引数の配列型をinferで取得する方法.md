---
tags:
  - typescript
  - type-challenge
---

可変長引数の配列型をinferで取得する方法
```ts
type MyParameters<T extends (...args: any[]) => any> =
  T extends (...args: infer params) => any ? [...params] : never;
```

[type-challenges/questions/03312-easy-parameters/README.ja.md...](https://github.com/type-challenges/type-challenges/blob/main/questions/03312-easy-parameters/README.ja.md)
Parameters で出題
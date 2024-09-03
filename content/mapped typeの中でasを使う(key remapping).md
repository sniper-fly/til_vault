---
tags:
  - typescript
  - type-challenge
---

mapped typeの中でasを使う(key remapping)
[TypeScript: Documentation - Mapped Types](https://www.typescriptlang.org/docs/handbook/2/mapped-types.html#key-remapping-via-as)
```ts
type MyOmit<T extends Object, K extends keyof T> =
  { [key in keyof T as key extends K ? never : key]: T[key] }
```
as による key remappingを使ったOmitの解法
---
tags:
  - typescript
  - type-challenge
---
typescriptの細かい文法

keyof は、インターフェースなどからunion型に変換が出来る
```ts
interface userInfo {
  name: string
  age: number
}
type keyofValue = keyof userInfo
// keyofValue = "name" | "age"
```

`[key in unionType]` でunionTypeを展開して複数要素のインターフェースを作れる
```ts
type name = 'firstname' | 'lastname'
type TName = {
  [key in name]: string
}
// TName = { firstname: string, lastname: string }
```

これの組み合わせ
```ts
type MyPick<T, K extends keyof T> = { [key in K]: T[key] }
```
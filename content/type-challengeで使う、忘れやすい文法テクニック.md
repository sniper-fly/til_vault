---
tags:
  - typescript
  - type-challenge
---
typescriptの細かい文法

https://www.typescriptlang.org/docs/handbook/2/mapped-types.html
mapped Type
as を使ったRemapping, neverでの除去、PropertyType以外のオブジェクトでのmaping
-, + 演算子でreadonlyや ?: のフラグを消すことが出来る

keyof any は全てのオブジェクトが取りうるkeyの型のunionを表してくれる
```
keyof any == (string | number | symbol)
```
また、ビルトインの`PropertyKey`というのもあり、これも同値

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
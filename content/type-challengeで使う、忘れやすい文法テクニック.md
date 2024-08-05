---
tags:
  - typescript
  - type-challenge
---
typescriptの細かい文法

`PromiseLike`
thenキーを持つようなオブジェクトもPromiseLikeの部分型として判定される

[ユニオン分配 (union distribution) | TypeScript入門『サバイバルTypeScript』](https://typescriptbook.jp/reference/type-reuse/union-distribution)
```ts
type NotDistribute<T> = [T] extends [string] ? true : false;
```
ユニオン分配を起こさせない方法がある
```ts
type A = NotDistribute<string>; // true
type B = NotDistribute<number>; // false
type C = NotDistribute<string | number>; // false `string | number`型は`string`型の部分型ではない
```

https://www.typescriptlang.org/docs/handbook/2/mapped-types.html
mapped Type
as を使ったRemapping, neverでの除去、PropertyType以外のオブジェクトでのmaping
-, + 演算子でreadonlyや ?: のフラグを消すことが出来る


以下での`T[number]`はunionTypeになる
```ts
type TupleToObject<T extends readonly (PropertyKey)[]> =
  { [key in T[number]]: key }
```
https://github.com/type-challenges/type-challenges/blob/main/questions/00011-easy-tuple-to-object/README.ja.md


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
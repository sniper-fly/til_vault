---
tags:
  - typescript
  - type-challenge
---

template literal typeでのinferはどう機能するのか？
[110 - Capitalize · Issue #759 · type-challenges/type-challen...](https://github.com/type-challenges/type-challenges/issues/759)

How does typescript determine which of x and tail should take up the rest characters? For example, if S is 'abc', why are x='a' and tail='bc', not x='ab' and tail='c? Is there any docs I can refer to?

If a string is only inferred using infer without any other information, the previous infer will only infer one character at a time, and the last infer will infer all the remaining characters, such as:
```ts
type Split<S> = S extends `${infer l}${infer r}` ? `${l} ${r}` : never
// Split<'123-4567890'> -> l = '1', r = '23-4567890' -> result = '1 23-457890'
```

If certain deduction conditions (string value type, It can be regarded as a constant) are added in the string's middle, the string will be divided according to the deduction conditions:
```ts
type Split<S> = S extends `${infer l}-${infer r}` ? `${l} ${r}` : never
// Split<'123-4567890'> -> l = '123', r = '4567890' -> result = '123 4567890'
```

Upon testing, I reckon this is how it works:

| TypeScript                       | Regex              |
| :------------------------------- | :----------------- |
| `${infer A}`                     | `/(.*)/`           |
| `${infer A}${infer B}`           | `/(.+?)(.*)/`      |
| `${infer A}${infer B}${infer C}` | `/(.+?)(.+?)(.*)/` |

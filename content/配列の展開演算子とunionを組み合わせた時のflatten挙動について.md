---
tags:
  - typescript
  - type-challenge
---

配列の展開演算子とunionを組み合わせた時のflatten挙動について
```ts
type hoge = Permutation<'A' | 'B' | 'C'>
type a = ['A', ...(['B', ...['C', ...[]]] | ['C', ...['B', ...[]]])]
// ==> type a = ["A", "B", "C"] | ["A", "C", "B"]
```
配列の展開演算子の中にunionがあるとき、配列が取りうる可能性を考慮して、
差異数的に２つの配列のunionになる

これを応用した問題が`Permutation`
[296 - Permutation (with explanations) · Issue #614 · type-ch...](https://github.com/type-challenges/type-challenges/issues/614)
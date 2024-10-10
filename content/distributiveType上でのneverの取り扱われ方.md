---
tags:
  - typescript
  - type-challenge
---

distributiveType上でのneverの取り扱われ方
`T extends hoge`でTがunionであるとき、distributeされるが
neverに関しては特殊な挙動
`'a' | never` は`a`として扱われる

`'a' | (never | 'b') | (never | never)` は`a | b`として扱われる

[296 - Permutation (with explanations) · Issue #614 · type-ch...](https://github.com/type-challenges/type-challenges/issues/614)
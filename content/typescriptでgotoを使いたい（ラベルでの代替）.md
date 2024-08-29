---
tags:
  - typescript
---

typescriptでgotoを使いたい（ラベルでの代替）
[ラベル - JavaScript | MDN](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Statements/label)
if文でもラベルを使うことができ、gotoのようなことが出来る
```ts
hogeBlock: if (hoge) {
  if (fuga) {
    if (piyo) break hogeBlock;
  } else {
    ...
  }
}
```
一番外側のブロックを抜けられる
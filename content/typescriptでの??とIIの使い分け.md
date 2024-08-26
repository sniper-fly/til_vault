---
tags:
  - typescript
---

typescriptでの??と||の使い分け
`??` と `||` は、TypeScriptやJavaScriptでよく使われる演算子ですが、それぞれ異なる目的で使用されます。

### `??`（Nullish Coalescing Operator）

`??` は「Nullish Coalescing Operator（ヌリッシュ・コアレッシング・オペレーター）」と呼ばれ、左側のオペランドが `null` または `undefined` である場合に、右側のオペランドを返します。それ以外の場合は、左側のオペランドを返します。

**例:**
```ts
const value1 = null ?? 'default'; // 'default'
const value2 = undefined ?? 'default'; // 'default'
const value3 = '' ?? 'default'; // '' (空文字列はnullishではない)
const value4 = 0 ?? 'default'; // 0 (0もnullishではない)
```

### `||`（Logical OR Operator）

`||` は「Logical OR Operator（論理OR演算子）」と呼ばれ、左側のオペランドが `falsy` な値（`false`, `0`, `'', null`, `undefined`, `NaN` など）である場合に右側のオペランドを返します。`falsy` でない場合は、左側のオペランドを返します。

**例:**
```ts
const value1 = null || 'default'; // 'default'
const value2 = undefined || 'default'; // 'default'
const value3 = '' || 'default'; // 'default' (空文字列はfalsy)
const value4 = 0 || 'default'; // 'default' (0はfalsy)
```
### 使い分け
- `??` を使用する場合: 値が `null` または `undefined` の場合にのみデフォルト値を使いたいとき。
- `||` を使用する場合: 値が `falsy` であればデフォルト値を使いたいとき。

### 実際の例
```ts
const userInput = ''; // ユーザーが何も入力しなかった場合

const valueUsingOr = userInput || 'default'; // 'default'
const valueUsingNullish = userInput ?? 'default'; // '' (userInput がnullishではないため)
```

このように、状況に応じて適切な演算子を使い分けることで、より期待に沿った挙動を実現できます。
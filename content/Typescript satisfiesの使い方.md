---
tags:
  - typescript
---
Typescript satisfiesの使い方

[TypeScript の satisfies 演算子は何に役立つのか](https://9sako6.com/posts/why-typescript-satisfies-operator)
型推論結果を残しつつ、型を満たすかどうかをチェックできる

[【TS】satisfiesじゃないとできないこと。\~無駄な変数を撲滅する\~。](https://zenn.dev/gemcook/articles/17f7a25dc88cb9)
[TypeScript 4.9のas const satisfiesが便利。型チェックとwidening防止を同時に行う](https://zenn.dev/tonkotsuboy_com/articles/typescript-as-const-satisfies)

型チェックを行いつつ、Typescriptの型推論結果が保持される
```ts
type ColorList = {
  [key in "red" | "blue" | "green"]: unknown;
};

const colorList = {
  red: "#ff0000",
  green: [0, 255, 0],
  blue: "#0000ff"
} satisfies ColorList;

// 配列のメソッドを実行
colorList.green.map(value => value * 2);
```

型注釈 の場合
```ts
const colorList: ColorList = {
  red: "#ff0000",
  green: [0, 255, 0],
  blue: "#0000ff"
};

// ❌エラー
// green は unknown なので、 map() は使えない
colorList.green.map(value => value * 2);
```

型注釈よりも型推論結果のほうがより厳密で細かい定義が出来そうな時、satisfiesは有効
unknown は Arrayであるための必要条件
型推論結果で得られる型がsatisfiesでチェックする型に対する十分条件の場合に便利
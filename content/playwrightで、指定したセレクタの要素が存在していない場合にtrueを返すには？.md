---
tags:
  - playwright
---

playwrightで、指定したセレクタの要素が存在していない場合にtrueを返すには？
以下の方法で、locatorがDOMにアタッチされていない場合にtrueを返すことができます。

1. count メソッドを使用して要素の存在を確認
```ts
const isDetached = (await page.locator('your-selector').count()) === 0;
console.log(isDetached); // 要素が存在しない場合 true, 存在する場合 false
```
count メソッドは、指定したセレクタに一致する要素の数を返します。count() が 0 を返した場合、その要素はDOMに存在していない、つまりアタッチされていないことを意味します。

2. isVisible メソッドを使用して要素が表示されているか確認
もし要素が存在しているが、表示されていない（例えばdisplay: noneやvisibility: hiddenのような状態）場合には、isVisibleを使用して確認できます。
```ts
const isDetached = !(await page.locator('your-selector').isVisible());
console.log(isDetached); // 要素が非表示または存在しない場合 true, 表示されている場合 false
```
ただし、isVisible は要素がDOMに存在している場合にその表示状態を確認します。要素が完全に存在しない場合は false を返します。
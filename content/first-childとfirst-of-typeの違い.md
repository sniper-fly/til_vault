---
tags:
  - CSS
---

first-childとfirst-of-typeの違い

[first-childとfirst-of-typeセレクタの違いってなに？違いを見てみよう！｜東京目黒区のWeb制作・ホ...](https://blog.8bit.co.jp/?p=16959)
囲んでいる要素の中での順番の数え方が違う
first-child は全ての種類の要素を含めて１番目
first-of-type は他にも色んな要素があったとしても、指定した最初の要素に対して適用される
p:first-of-type というセレクタを書けば、p以外の要素が最初に来ていても無視される

[:first-child - CSS: カスケーディングスタイルシート | MDN](https://developer.mozilla.org/ja/docs/Web/CSS/:first-child)
 [first-of-type - CSS: カスケーディングスタイルシート | MDN](https://developer.mozilla.org/ja/docs/Web/CSS/:first-of-type)

tailwindでのfirst-child, first-of-typeの違いは？

firstは単純に親要素の中で最初の要素なら適用される
first-of-typeは親要素の中で、そのクラスが適用されている要素が初登場である場合は適用される
```html

<div>
	<h1 class="first:text-red-500"> red </h1>
	<div class="first-of-type:text-blue-500"> blue </div>
	<h1 class="first:text-red-500"> not red </h1>
</div>

```
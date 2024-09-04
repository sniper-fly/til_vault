---
tags:
  - HTML
---

picture html tagで条件によって表示する画像を変更する
[\<picture\>: 画像要素 - HTML: ハイパーテキストマークアップ言語 | MDN](https://developer.mozilla.org/ja/docs/Web/HTML/Element/picture)
```html
<picture>
  <source srcset="mdn-logo-wide.png" media="(min-width: 600px)" />
  <img src="mdn-logo-narrow.png" alt="MDN" />
</picture>
```
srcsetで利用したい画像を指定し、mediaでそれを使うために満たすべき条件を書く
この場合、画面の大きさが600px未満になった場合はpictureタグ内の次の要素を使う
この場合はimgタグの要素を使う

[How to use next.js Image component with HTML \<picture\> ele...](https://stackoverflow.com/questions/71275942/how-to-use-next-js-image-component-with-html-picture-element)
Nextjsでsourceタグを使う方法
getImgProps実験的関数を使う
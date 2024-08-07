---
tags:
  - FrontendMentor
  - TailwindCSS
---
行間の調整は`leading-x`
文字間の調整は`tracking-x`

`justify-center` は主軸に対して真ん中に寄せる
`items-center` は交差軸に対して真ん中に寄せる

親要素いっぱいの大きさまで要素を広げたいときは `w-full`
`w-max` はテキストがオーバーフローしてはみ出た時にも絶対に折り返さないという意味


 hidden invisible の違いとは？

[Display - Tailwind CSS](https://tailwindcss.com/docs/display#hidden)
hiddenはDOMからもなくなった扱いになる
hidden の対になるのは block など
CSSでは以下のような違い
block -> display: block;
hidden -> display: none;

[Visibility - Tailwind CSS](https://tailwindcss.com/docs/visibility#invisible)
invisibleは透明になるものの、DOMには存在している扱い
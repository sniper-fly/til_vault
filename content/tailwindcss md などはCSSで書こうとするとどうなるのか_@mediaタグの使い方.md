---
tags:
  - TailwindCSS
---

tailwindcss md: などはCSSで書こうとするとどうなるのか_@mediaタグの使い方
[CSS - @media - とほほのWWW入門](https://www.tohoho-web.com/css/rule/media.htm)
```css
@media (min-width: 768px) {
  .areas_card_large {
    grid-template-areas:
      "..... card2 ....."
      "card1 card2 card4"
      "card1 card3 card4"
      "..... card3 .....";
  }
}
```
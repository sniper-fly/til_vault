---
tags:
  - TailwindCSS
---

TailwindCSSでインライン要素を右寄せする方法

ml-autoを使う
```html
  <img src="example.jpg" alt="example image" class="ml-auto">
```

float-rightを使う
```html
  <img src="example.jpg" alt="example image" class="float-right">
```

grid, justify-items-endを使う
```html
<div class="grid justify-items-end">
  <img src="example.jpg" alt="example image">
</div>
```
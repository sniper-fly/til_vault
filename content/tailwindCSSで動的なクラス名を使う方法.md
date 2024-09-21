---
tags:
  - TailwindCSS
---

tailwindCSSで動的なクラス名を使う方法
[Just-in-Time Mode - Tailwind CSS](https://v2.tailwindcss.com/docs/just-in-time-mode#built-in-important-modifier:~:text=this%20feature%20responsibly.-,Dynamic%20values,-Note%20that%20you)
```jsx
<div className={ size === 'lg' ? 'mt-[22px]' : 'mt-[17px]' }></div>
```
このような使い方だと問題ない
arbitarary valueを計算して動的に使うことは出来ない
styleタグを使う代替案がある
```html
<div style="background-color: {{ userThemeColor }}"></div>
```
---
tags:
  - TailwindCSS
---

tailwindcssでgrid template areaを使うには
[Best alternative to "grid-template-areas" in tailwind · tail...](https://github.com/tailwindlabs/tailwindcss/discussions/2784)
[Tailwind CSS - SavvyWombat](https://savvywombat.com.au/tailwind-css/grid-areas)
grid-ares のtailwind pluginを使う手もある

そもそものgridどうやって使うのか
[CSS Grid Layout を極める！（基礎編） #CSS3 - Qiita](https://qiita.com/kura07/items/e633b35e33e43240d363#%E3%82%B9%E3%83%86%E3%83%83%E3%83%97%EF%BC%93---%E6%96%B9%E6%B3%95%EF%BD%82-%E3%82%A8%E3%83%AA%E3%82%A2%E3%81%AB%E5%90%8D%E5%89%8D%E3%82%92%E4%BB%98%E3%81%91%E3%81%A6%E6%8C%87%E5%AE%9A%E3%81%99%E3%82%8B)

CSS moduleを使う方法もある
`styles.module.css` を配置し、importする
`import styles from "./styles.module.css";`

md以上で十字形に配置するサンプル
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
gridで何も配置しない、空白を表現するには....を使う

cardの方はfull arbitrary valueを使う
```ts
  <Card
	className="[grid-area:card1]"
	...
```
[Adding Custom Styles - Tailwind CSS](https://tailwindcss.com/docs/adding-custom-styles#arbitrary-properties)

sample
[frontend\_mentor/src/app/four-card-feature-section-master at...](https://github.com/sniper-fly/frontend_mentor/tree/master/src/app/four-card-feature-section-master)
---
tags:
  - typescript
---
ts,jsで文字列の特定の文字を複数回置換する方法

replace(" ", "-") のような方法だと、一回しか置換されない
```ts
  const searchQuery = `my hero academia the day`.replace(" ", "-");
	// my-hero academia the day
```

複数まとめてreplaceしたいとき、正規表現の/gが便利
```ts
  const searchQuery = `my hero academia the day`.replace(/\s/g, "-");
	// my-hero-academia-the-day
```
---
tags:
  - obsidian
---
ObsidianクライアントとQuartzでの見た目を統一したい

Quartzでデプロイする際に、Obsidianの見た目とmdをHTMLとして解釈した際の見た目が異なる

下記のプラグインで修正可能
[HardLineBreaks](https://quartz.jzhao.xyz/plugins/HardLineBreaks)

プラグインの導入方法は以下
[Configuration](https://quartz.jzhao.xyz/configuration#plugins)

`quartz.config.ts` のplugins に追加するだけ
```ts
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "filesystem"],
      }),
	  ...
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
      Plugin.HardLineBreaks(), // ←ここ
    ],
	...
```
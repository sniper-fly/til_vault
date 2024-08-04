---
tags:
  - Question
  - HTML
  - CSS
  - FrontendMentor
---

親要素をrounded指定しても子要素をまとめてroundedできない件
Nextjs の Image はブロック要素？インライン？

![[Screenshot from 2024-07-31 17-51-19.png]]

親要素で `rounded` を指定しても反映されない
```tsx
    <div className="flex h-screen items-center justify-center">
      <main className="flex flex-row rounded-2xl">
        {/* 画像を半分配置 */}
        <Image
          src={`${basePath}/image-product-desktop.jpg`}
          alt="image-product-desktop"
          width={600}
          height={900}
          className="w-1/2"
        />
        {/* 文章とボタンの配置 */}
        <article className="w-1/2 bg-white">hoge</article>
      </main>
    </div>
```

A. `rounded-l-xl` `rounded-r-xl` などを使うことで左右のどちらかにのみ丸みをつけたりできる

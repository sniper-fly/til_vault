---
tags:
  - typescript
  - webScraping
---

playwrightなしで純粋にウェブページを解析してスクレイピングする方法
https://qiita.com/Syoitu/items/6a136e3b8d2fb65e51a2

cheerioというライブラリが使えそう
jquery風の文法が使える
https://github.com/cheeriojs/cheerio

node-html-parserというのも人気
https://github.com/node-projects/node-html-parser

様々な選択肢がある
https://www.zenrows.com/alternative/cheerio

jsdomなども使える
https://qiita.com/sueasen/items/9e3498d79d4cc10ba553

GPTによる回答
https://chatgpt.com/share/b4a2609c-98c9-4576-ac5b-6e7ec34223f7

Cheerio: 軽量でjQueryライクなAPIを提供し、HTMLの解析と基本的な操作に適しています。ブラウザの完全なエミュレーションは不要だが、簡単なスクレイピングやデータ抽出が必要な場合に最適です。

Node-html-parser: 非常に軽量で基本的なHTML解析に適しており、リソース消費を抑えたい場合に適しています。高度な機能は必要ないが、シンプルな解析が必要な場合に最適です。

JSDOM: 完全なブラウザエミュレーションが必要な場合に適しており、クライアントサイドのスクリプトをサーバーサイドで実行する場合に最適です。リソース消費が大きいため、重い処理には注意が必要です。

jQueryが使えると便利、かつ完全なブラウザエミュレーションは必要ないので、今回はCheerioでスクレイピングしていく

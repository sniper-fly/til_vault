---
tags:
  - SQL
---

サブクエリで集計してからjoin vs 全部joinで結合してから集計
joinする行の数が少ないほど速い
ただし、サブクエリの結果に関してはインデックスは設定されない
[SQLでサブクエリを上手に使う6パターン | by Nyle | Nyle Engineering Blog | Med...](https://medium.com/nyle-engineering-blog/sql%E3%81%A7%E3%82%B5%E3%83%96%E3%82%AF%E3%82%A8%E3%83%AA%E3%82%92%E4%B8%8A%E6%89%8B%E3%81%AB%E4%BD%BF%E3%81%866%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3-bae5ae35b962)
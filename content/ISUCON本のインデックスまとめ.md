---
tags:
  - ISUCON
  - SQL
---
ISUCON本のインデックスまとめ

[[クラスターインデックスとは]]

[[covering indexとは？]]

また、一度の検索で利用できるインデックスは１つだけ！！

Btreeの特性上、前方一致にしかインデックスを利用できない
全文検索エンジンを使うことで単語分割などを行って転地インデックスを作成可能
[転置インデックスを実際に試してみる](https://zenn.dev/kun432/scraps/0230c0dcbacddc)

全文検索インデックスの作成コマンド
`ALTER TABLE comments ADD FULLTEXT INDEX comments_full_idx (comment) WITH PARSER ngram;`

> テキストの分割方式として N-gram を利用しています。検索するには MATCH (column)
AGAIST (expr) という全文検索用の関数を利用します

検索に要するSQL文
`SELECT * FROM comments WHERE MATCH (comment) AGAINST ('データベース' IN BOOLEAN MODE);`
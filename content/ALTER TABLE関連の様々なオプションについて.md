---
tags:
  - SQL
---

ALTER TABLE関連の様々なオプションについて
[MySQL :: MySQL 8.0 リファレンスマニュアル :: 13.1.9 ALTER TABLE ステートメント](https://dev.mysql.com/doc/refman/8.0/ja/alter-table.html)

例えば、postsテーブルのcreated_at_idxという名前のindexを削除する
```sql
ALTER TABLE posts DROP INDEX created_at_idx
```
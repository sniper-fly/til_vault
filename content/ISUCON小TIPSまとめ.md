---
tags:
  - ISUCON
---

## テーブル情報を知るには？
show create table コマンドとは？
create tableをする際に必要なコマンドを表示することで、
テーブルの情報を知ることが出来る

## インデックス作成
```sql
ALTER TABLE comments ADD INDEX post_id_idx(post_id);
```

下記エラーが出る場合は
```
mysqladmin: connect to server at 'localhost' failed
error: 'Access denied for user 'root'@'localhost' (using password: NO)'
```

パスワード付きで実行する
```bash
mysqladmin flush-logs -p
```

## topコマンドの表示の更新を一時停止するには？
Ctrl-s を使うとターミナルの表示が止まる
Ctrl-q で再開

top -p 53592 -p 44601 のように複数指定できる

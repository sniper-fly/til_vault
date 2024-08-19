---
tags:
  - SQL
---

mysqlで、特定テーブルのレコードを全消去する
`SpotifyTrack`テーブルの全てのレコードを削除するには、以下のSQLクエリを使用します。
```sql
DELETE FROM SpotifyTrack;
```

テーブル自体も削除したい場合は
```sql
DROP TABLE SpotifyTrack;
```
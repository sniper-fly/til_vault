---
tags:
  - mysql
  - tryAndError
---

mbind: Operation not permitted を防ぐ
[【Docker+MySQL】「mbind: Operation not permitted」の対応│おくやんのテックダイ...](https://okuyan-techdiary.com/mysql-mbind-error/)
```
  db:
	...
    cap_add:
      - SYS_NICE
```
dbコンテナ起動時のオプションを追加するだけ
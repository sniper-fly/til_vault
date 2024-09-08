---
tags:
  - mysql
  - ISUCON
---

mysqlが作成するファイルの権限を設定する方法
[MySQL :: MySQL 8.0 リファレンスマニュアル :: B.3.3.1 ファイル権限の問題](https://dev.mysql.com/doc/refman/8.0/ja/file-permissions.html)
UMASK環境変数を設定することで、生成されるファイルのパーミッションを変更できる
マスクと言いながら普通にchmodで設定する値と変わらない
つまり、644を作りたければ0644と設定する
0を先頭につけない場合は10進数とみなされる
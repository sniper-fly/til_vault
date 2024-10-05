---
tags:
  - mysql
---

mysqlでパスワードなしrootログインを可能にする

一旦普通にログイン
`mysql -u root -p`
### 2. MySQL内で`root`ユーザーのパスワードを無効化する
MySQLのコンソールにログインしたら、`root`ユーザーの認証方法を変更します。`mysql`データベースの`user`テーブルを更新します。
```sql
USE mysql;
UPDATE user SET authentication_string='', plugin='mysql_native_password' WHERE User='root';
FLUSH PRIVILEGES;
```

`plugin`カラムを`mysql_native_password`に設定し、`authentication_string`カラムを空にすることで、パスワードなしでのログインを許可します。

dockerの場合は、普通にdownしてからupして再起動すれば設定が反映される
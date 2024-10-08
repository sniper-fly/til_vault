---
tags:
  - ISUCON
---

=========================
[[2024-10-06]]
プロセス・スレッド

PHP, Rubyはマルチプロセス、シングルスレッド
goroutine はシングルプロセス、マルチスレッドで軽量スレッドを使う
スレッドは同じプロセス上のメモリ空間を共有する

ブラウザがgzipエンコーディングに対応していた場合はレスポンスを1/5ぐらいに圧縮できる
元々のファイルサイズが小さい場合はgzipすることで余計にサイズが大きくなることがある

静的なファイルは事前にgzip圧縮することでcpuの負担を下げられる

ウェブサーバーとアプリケーションサーバー間の通信もgzip圧縮すべき
これをしないとこれらの通信帯域を5倍消費することになる

TLS通信について
ssl_session_cache設定でセッション情報をキャッシュ可能
RSAよりECDSA鍵の方が安全・パフォーマンス高
HPACK→HTTP/2で登場したヘッダー圧縮技術
HTTP/2の方がパフォーマンス良い
AES-NI
TLS1.3

キャッシュはプログラムが複雑になる

キャッシュ実装双方
キャッシュにデータがなければキャッシュを生成して結果を保存する

=========================
[[2024-09-21]]

query-digesterの使い方がいまいちわからない

pt-query-digestの
Lock time とは？これが大きいとなにが予想される？
他のスレッドによるロックの待ち時間

InnoDBとは何か？

show create tableを使った際にもENGINE=InnoDB と表示される

=========================
[[2024-09-18]]

>しかし、この機能で出力されたメトリクスは、シナリオ実行中の 1 リクエストにつき複数のメトリ
クスが出力されている生のデータです。そのため、たとえば URL 別に平均レスポンスタイムを出し
たい場合には、別途なんらかの方法で集計する必要があります。

どういうこと？

/var/ 以下のファイルはhaltすると消える？
→/tmp は消えるが、/var は消えない

一貫性とは？
不具合が発生した倍は処理自体を取り消したり、前後で矛盾がない状態を保つ性質
RDBMSは複数サーバーにデータを分散させることでスケーラビリティを向上させることが難しい

既存のRDBMSでは難しかったスケールアップの問題を解決したのがNoSQL
memcached, Redis, DynamoDB

データ不整合が発生しない仕組みを担保しつつ、複数サーバーに分散するために作られたのがNewSQL
TiDBやCockroachDB, Cloud Spanner

=========================
[[2024-09-12]]

curlのOオプションとは
```
-O, --remote-name
Write output to a local file named like the remote file we get. (Only the file part of the remote file is used, the path is cut off.)
```

isuconのvmにsudoコマンドにパスワードは必要ない
sudo su とすることでrootにログイン可能

alpコマンドのインストール
```
> curl -O https://github.com/tkuchiki/alp/releases/download/v1.0.21/alp_linux_amd64.tar.gz
> tar -xzf alp_linux_amd64.tar.gz
> mv alp /usr/bin
```

議題
- vscodeでいい感じにsshして複数ファイルの管理が出来ると良い
root権限でvscode sshできる？
- git管理どうする？
=========================
[[2024-09-11]]

[Install Vagrant | Vagrant | HashiCorp Developer](https://developer.hashicorp.com/vagrant/docs/installation)

[GitHub - catatsuy/private-isu: a web application performance...](https://github.com/catatsuy/private-isu)
これによると

> 手元にansibleをインストールして`vagrant up`すればprovisioningが実行される。

ansibleとは何か？
vagrantといい感じに統合された設定管理ツール。らしい。
[Installing Ansible on specific operating systems — Ansible C...](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#id6)

=========================
[[2024-09-06]]

ログのローテートをする意味?
→チューニング前後のログが混ざってしまい、結果の比較ができなくなる

EXPLAIN 文を利用すると実行計画を調べられる
EXPLAIN文の直後にこのように書く
```sql
EXPLAIN SELECT * FROM `comments` WHERE `post_id` = 9995 ORDER BY `created_at` DESC LIMIT 3;
```

```
+----+-------------+----------+------------+------+---------------+------+---------+------+-------+----------+-----------------------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows  | filtered | Extra                       |
+----+-------------+----------+------------+------+---------------+------+---------+------+-------+----------+-----------------------------+
|  1 | SIMPLE      | comments | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 99918 |    10.00 | Using where; Using filesort |
+----+-------------+----------+------------+------+---------------+------+---------+------+-------+----------+-----------------------------+

key がNULLなのでインデックスは利用されておらず
rowsによって99918行の読み込みが必要になっている
```

abコマンドの実行結果はどこかに自動保存しておきたい
結果の比較が難しい

[[mysqlが作成するファイルの権限を設定する方法]]

nginxのプロセス番号はしょっちゅう変更されてしまう

dstat --cpu
で時系列でcpuの情報が取得できる
usr sys とかの読み方がわからない
19987
19616

=========================
[[2024-09-05]]

mysql logのファイルの閲覧権限がおかしいので、my.cnfで744に出来るかどうか

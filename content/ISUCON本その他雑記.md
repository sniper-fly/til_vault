---
tags:
  - ISUCON
---
=========================
[[2024-10-22]]
nginxのログ設定ファイル
スロークエリログの解析ツール導入
percona-toolkitとmysqldumpslowの違い

index設定前にまずベンチマークを測る

bench変化なし
indexの設定
mysql slow query logを確認, 該当箇所のクエリ回数のexplainが減っているか
後にもう一度bench
最新のpprofを表示するサーバーを起動するコマンドを用意する
pprofの変化を観察する
pprofを読んでいるが、ここからボトルネックが読み取れない

topの観察  / 事前のデータがないのでわからない

静的ファイルのnginxによる配信

画像ファイルをファイルに書き出す処理参考

https://github.com/stefafafan/private-isu/pull/6/files

=========================
[[2024-10-21]]
gitで余計に多くのファイルが管理されてしまっている
addしたものを戻すには
適切にgitignoreする

pprofの検証

TODO
isucon9で vscode ssh
pprofを使う

golangの名前解決
まずgolangが入っていないので、最新版をインストール
`wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz`

=========================
[[2024-10-13]]
reniceコマンド
プロセスの優先度を変更する

=========================
[[2024-10-11]]

Goのexecはシェルを経由しない
bashなどで利用される展開などが使えない

外部コマンド呼び出しの箇所を見て、不要そうなら標準ライブラリで再実装する

コネクションとは？

コネクションを使い回す、とは？
TCPコネクションを使い回せない場合、HTTPリクエストを送信するたびにハンドシェイクが必要
Goではhttp.Clientの変数を使い回すことでコネクションを使い回せる

> ただし、Go の http.Client には他にも注意点があります。
> Go はレスポンスの Body の Close を忘れると TCP コネクションが再利用されないため、
> リスト 7 のコードのように res.Body.Close() を必ず実行するようにします。
> また、res.Body.Close() を実行していても、レスポンスの Body を Read せずに Close すると都度 TCP コネクションが切断されます。そのため、リスト 7 のように io.ReadAll などを使ってレスポンスの Body を読み切る必要があります 注 9 。
> こういった細かい注意点があるため、各ライブラリの使い方を調べて、実装したプログラムが想定した挙動をしているか確認するようにしましょう。

意味がわからない

GoのhttpClientはデフォルトでタイムアウトが設定されていない

静的ファイルはMySQLでいちいち扱うとメモリ負担がかかるのでnginxから直接配信したい

nginx画像配信で認証を行う時のレスポンスヘッダ
`X-Accel-Redirect`

画像ファイルを変更した場合、URLも同時に変更すべし
クライアントのキャッシュは基本的に削除できない
別の画像であると認識されなければならない

Cache-Control レスポンスヘッダの仕様
`Cache-Control: max-age=86400`
1日間キャッシュが有効

=========================
[[2024-10-10]]

キャッシュをバッチで更新する手もある

キャッシュの監視
キャッシュデータを取得した際にキャッシュが存在していた場合はキャッシュヒット、ない場合はキャッシュミスと呼ぶ
ウェブアプリに変更を加えるとキャッシュヒット率が変わることがあるので継続的な監視が重要

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

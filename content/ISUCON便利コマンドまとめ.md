---
tags:
  - ISUCON
---
vagrantでの仮想マシンの終了コマンド(`vagrant destroy`だと再度構築が必要になってしまう)
`vagrant halt`

Vagrantfileに則って仮想マシンを構築・起動する
`vagrant up`

仮想マシンにログインする
`vagrant ssh <app-name>`

nginxの設定再読込コマンド
`systemctl nginx reload`

nginx再起動(ダウンタイムあり)
`systemctl nginx restart`

nginx の再起動方法(違いわからず)
`nginx -s reopen`

nginxのログを確認する
`systemctl status nginx.service`

nginxのconfigのsyntaxチェックを行う
`nginx -t`

スロークエリの集計ログを見る
`mysqldumpslow <slow-log-file-name>`

ログファイルの更新をMysqlに検知する
`mysqladmin flush-logs`

ファイルのインストール
`curl -O https://xxxx`
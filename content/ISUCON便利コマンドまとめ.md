---
tags:
  - ISUCON
---
vagrantでの仮想マシンの終了コマンド(`vagrant destroy`だと再度構築が必要になってしまう)
`vagrant halt`

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
`mysqldumpslow`

ファイルのインストール
`curl -O https://xxxx`
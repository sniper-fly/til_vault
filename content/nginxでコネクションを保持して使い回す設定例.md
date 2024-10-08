---
tags:
  - ISUCON
  - nginx
---

nginxでコネクションを保持して使い回す設定例
アップストリームサーバーとのコネクション管理
コネクションを保持して使いまわしたい場合（キープアライブ）
設定例
```
location / {
	proxy_http_version 1.1;
	proxy_set_header Connection "";
	proxy_pass http://app;
}

upstream app {
	server localhost:8080;
	keepalive 32;
	keepalive_requests 10000;
}
```
大量のリクエストを受け付けるサーバーではコネクションの作り直しは負荷があがる

Linux の ss コマンドを利用して Linux 上で利用しているネットワークやソケットの情報を収集し、グラフ化することで TCP の様々な状態のコネクション数の変動を見る
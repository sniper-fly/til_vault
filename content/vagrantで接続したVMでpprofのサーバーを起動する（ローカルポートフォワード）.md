---
tags:
  - Vagrant
  - ISUCON
---

vagrantで接続したVMでpprofのサーバーを起動する（ローカルポートフォワード）
http://192.168.56.6:6070
にアクセスしたが、ホスト側では確認できず

ネットワークデバッグ
ホスト側から開通してるかどうか調べる＆VM側から対象ポートが開通してるか調べる

sshのローカルポートフォワードが必要らしい
```
ssh -L 6070:localhost:6070 isucon9
```

`vagrant ssh app -- -L 6070:localhost:6070`
これで接続したセッションで、
`go tool pprof -http=localhost:6070 pprof.app.samples.cpu.001.pb.gz`
これを行い、
http://192.168.56.6:6070
にアクセスするのではなくホスト側で `http://localhost:6070`にアクセスする
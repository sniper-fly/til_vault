---
tags:
  - Vagrant
  - ISUCON
---

vagrantでprivate-isuのベンチマークインスタンスを動かす
private-isuより
>#### 初期データを用意する
必要になるので、以下の手順を行う前に必ず実行すること。
```shell
make init
```

`/home/isucon/private_isu.git` ディレクトリに存在するMakefileで`make init`

また、ベンチマークを行うための実行ファイル（バイナリ）もデフォルトでは用意されていないので、
`/home/isucon/private_isu.git/benchmarker` にcdしてから別途`make`を行う必要がある
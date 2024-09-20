---
tags:
  - Vagrant
  - ISUCON
---

##  vagrantでprivate-isuのベンチマークインスタンスを動かす

private-isuより
[GitHub - catatsuy/private-isu: a web application performance...](https://github.com/catatsuy/private-isu#:~:text=%E5%BF%85%E8%A6%81%E3%81%AB%E3%81%AA%E3%82%8B%E3%81%AE%E3%81%A7%E3%80%81%E4%BB%A5%E4%B8%8B%E3%81%AE%E6%89%8B%E9%A0%86%E3%82%92%E8%A1%8C%E3%81%86%E5%89%8D%E3%81%AB%E5%BF%85%E3%81%9A%E5%AE%9F%E8%A1%8C%E3%81%99%E3%82%8B%E3%81%93%E3%81%A8%E3%80%82)
>#### 初期データを用意する
必要になるので、以下の手順を行う前に必ず実行すること。
> `make init`

`/home/isucon/private_isu.git` ディレクトリに移動し、
同ディレクトリに存在するMakefileで`make init`

また、ベンチマークを行うための実行ファイル（バイナリ）もデフォルトでは用意されていないので、
`/home/isucon/private_isu.git/benchmarker` にcdしてから別途`make`を行う必要がある
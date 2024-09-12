---
tags:
  - Vagrant
  - ISUCON
---

isuconをVagrantで動かした際にホスト側からウェブブラウザにアクセスする方法
`ip a`コマンド でデバイス上のネットワークインターフェースに関連するIPアドレス情報を表示

enp0s8 の結果のinetのアドレスにアクセスすればイケるっぽい
ベンチマークのときもこのアドレスを使う
```
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:8f:02:96 brd ff:ff:ff:ff:ff:ff
    inet 192.168.56.4/24 metric 100 brd 192.168.56.255 scope global dynamic enp0s8
       valid_lft 382sec preferred_lft 382sec
    inet6 fe80::a00:27ff:fe8f:296/64 scope link 
       valid_lft forever preferred_lft forever
```
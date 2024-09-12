---
tags:
  - Vagrant
  - Infra
  - ISUCON
---

vagrantを扱うための超基本3コマンド,up,destroy,ssh
[What is Vagrant? | Vagrant | HashiCorp Developer](https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-index)
> three of the most important Vagrant commands to understand.
`vagrant init xxxx` で初期化処理を行う→Vagrantfileができる
`vagrant up` で用意されているVagrantfileに則って環境が作られる
`vagrant destroy`で環境を破棄する
`vagrant ssh`で作った環境に接続できる
---
tags:
  - ISUCON
  - Vagrant
---
-  virtual boxのインストール

- vagrantのインストール
[Install | Vagrant | HashiCorp Developer](https://developer.hashicorp.com/vagrant/downloads)

- ansibleのインストール
[Installing Ansible on specific operating systems — Ansible C...](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu)

- Vagrantfileがあるディレクトリで`vagrant up`を実行
安定して一回で成功するとは限らないので、失敗しても何度でも試す
`vagrant status`で状況を確認して動いていたら `vagrant ssh app` でログインする
`sudo su`でrootで操作可能


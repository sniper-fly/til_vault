---
tags:
  - Zenn
---
terraform のarchive_fileの仕様で、null_resourceが実行される前にzip化されてしまう
そのため、ソースファイルの変更を検知してapplyしてもビルド前のコードがアップロードされてしまう
そもそも、terraform applyの段階ではnpmコマンドを実行できない
terraformの実行順序を制御するのは難しいので、makefileによって順番を制御する
- ソースファイルの変更を検知
- ビルド
- terraformの機能でarchive_fileする

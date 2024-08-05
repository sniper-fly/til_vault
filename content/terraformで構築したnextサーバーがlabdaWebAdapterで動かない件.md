---
tags:
  - AWS
  - Terraform
---

terraformで構築したnextサーバーがlabdaWebAdapterで動かない件
[API GatewayとLambdaでNext.jsをAWSにデプロイする with Terraform](https://zenn.dev/yamakenji24/articles/deploy-nextjs-with-aws)
指示通り、cloudfrontでのデプロイのところまでできたがアクセスしても応答がない
どのようにデバッグすれば良いのだろうか...
lambdaのテストをしてログを見ると何やらサーバーが0.0.0.0で動いてはいる模様

このコマンドを実行させられたが、何の意味があるのか？
```bash
aws lambda update-function-code --function-name exampleLambdaRepo --image-uri xxxx.dkr.ecr.ap-northeast-1.amazonaws.com/example_lambda_repo:latest
```
lambdaのイメージが更新された場合に使うコマンドらしい
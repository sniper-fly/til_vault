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

[Deploy Next JS v13.x to AWS Lambda using aws-lambda-web-adap...](https://medium.com/@jake-smith/deploy-next-js-v13-x-to-aws-lambda-using-aws-lambda-web-adapter-dd5308d75848)
LWA はデフォルトで8080番でportのやり取りをしているらしいので、DockerfileのENVにPORTの書き換えを試してみる

portの書き換えで動作するようになったが、loading画面のままで表示されてくれない
どういうエラーが発生しているのかがデバッグできないので、ロググループの作成必須

または、lambdaの環境をローカルに作ってlambda web adapterをローカルで動作させられないか検討

[AWS Lambdaの関数 URL(Function URLs)を試してみた | DevelopersIO](https://dev.classmethod.jp/articles/try-aws-lambda-function-urls/)
function urlを発行してアクセスしたら無事に正しいページを表示することができた
ただし、初回アクセス時は重い
また、API gateway ではなぜかやはり表示ができない

[[2024-09-17]]
やはりapi gatewayからは正しくstaticのキャッシュが読み込めない模様
![[Screenshot from 2024-09-17 18-09-30.png]]
よく見ると、URLのパスが違うのではないか？
next.js側では`http://domain/_next` からファイルを転送しようとしているが、
正しくは`http://domain/prod/_next` にURLが送られなければならないのでは？

lambda URLでのネットワークリクエストについても詳しく調査して、URLが適正に動いていればこの問題である可能性が高い

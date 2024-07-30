---
tags:
  - AWS/lambda
  - lambda_web_adapter
---

https://serverless.co.jp/blog/g30vzpio0ww/
zipでnext.js をデプロイ
CloudFront, S3なども活用する方法

terraform でlwaリソースを整備している例
https://zenn.dev/yamakenji24/articles/deploy-nextjs-with-aws

next.config.mjs にstandalone記述を足す必要がありそう
https://github.com/awslabs/aws-lambda-web-adapter/blob/main/examples/nextjs/app/Dockerfile

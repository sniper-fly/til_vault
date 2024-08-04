---
tags:
  - AWS/lambda
  - lambda_web_adapter
---

[Dockerを使わない、Remix / Next.js 14 など最新ウェブフレームワークのAWS完...](https://serverless.co.jp/blog/g30vzpio0ww/)
zipでnext.js をデプロイ
CloudFront, S3なども活用する方法

terraform でlwaリソースを整備している例
[API GatewayとLambdaでNext.jsをAWSにデプロイする with Terraform](https://zenn.dev/yamakenji24/articles/deploy-nextjs-with-aws)

aws_lambda_function の下記の２箇所が、docker起動のポイント
```hcl
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.example_lambda_repo.repository_url}:latest"
```

next.config.mjs にstandalone記述を足す必要がありそう
[aws-lambda-web-adapter/examples/nextjs/app/Dockerf...](https://github.com/awslabs/aws-lambda-web-adapter/blob/main/examples/nextjs/app/Dockerfile)

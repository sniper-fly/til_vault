---
tags:
  - Terraform
  - AWS/lambda
---

chromium lambda layerをterraformで構築する
```
resource "aws_s3_bucket" "chromium_upload_bucket" {}

resource "aws_s3_object" "chromium_layer_zip" {
  bucket = aws_s3_bucket.chromium_upload_bucket.bucket
  key    = "chromiumLayers/chromium-v127.0.0-layer.zip"
  source = "./chromium-v127.0.0-layer.zip" # ローカルファイルのパス
}

resource "aws_lambda_layer_version" "chromium_layer" {
  layer_name  = "chromium"
  description = "Chromium v127.0.0"
  s3_bucket   = aws_s3_bucket.chromium_upload_bucket.bucket
  s3_key      = aws_s3_object.chromium_layer_zip.key

  compatible_runtimes      = ["nodejs20.x"] # 必要なランタイムを指定
  compatible_architectures = ["x86_64"]     # アーキテクチャを指定
}
```

lambdaでlayerを組み合わせるには
`layers = [aws_lambda_layer_version.chromium_layer.arn]` を
aws_lambda_function  リソースに足すだけ

[\[BUG\] Error: spawn Unknown system error -8 · Issue #222 · ...](https://github.com/Sparticuz/chromium/issues/222)
input directory "/var/bin" does not exist on AWS Lambda
のエラーを解決するには下記の設定を足す
```ts
    executablePath: await binChromium.executablePath(
      "/opt/nodejs/node_modules/@sparticuz/chromium/bin"
    ),
```
---
tags:
  - Terraform
---

Terraformで特定リソースのリージョンを変更したい
us-east-1でしか使えないようなので、このリソースだけproviderを変更したい
[\[Terraform\] Multi Providerで特定のリソースだけ別リージョンに作成したい](https://zenn.dev/samuraikun/scraps/f438c74690bb76)

プロバイダーの設定をリソースレベルで指定
プロバイダーを定義
us-east-1 用のプロバイダーを定義します。
```
provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}
```

プロバイダーをリソースに指定
特定のリソースでこのプロバイダーを指定します。
```
resource "aws_s3_bucket" "example" {
  provider = aws.us_east_1
  bucket   = "my-special-bucket"
}
```
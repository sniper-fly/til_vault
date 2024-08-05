---
tags:
  - AWS
  - Cloud
  - Terraform
---

terraformでECRを作ってイメージをpushする
```hcl
resource "aws_ecr_repository" "foo" {
  name                 = "bar"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
```
ecrにイメージをpushする
プライベートリポジトリは月500MBまで、パブリックは50GBまで無料利用できる
パブリックとプライベートの違い、課金方法の違いがわからない
[Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)
→`aws_ecr_repository` で作成されるECRレポジトリはプライベート

下記がdocker imageをpushするまでの一連の流れ
```bash
# まずログイン
%> aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin xxxuseridxxx.dkr.ecr.ap-northeast-1.amazonaws.com

%> docker tag anitunes:1.5 "xxxuseridxxx.dkr.ecr.ap-northeast-1.amazonaws.com/example_lambda_repo"

%> docker push "109026126473.dkr.ecr.ap-northeast-1.amazonaws.com/example_lambda_repo"
```
タグをつけるときにバージョンをつけない場合はlatestが使用される
また、ECRのコンソールからURIをコピーできるので、これをそのままコピペで良い
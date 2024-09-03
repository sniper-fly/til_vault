---
tags:
  - Docker
  - Terraform
  - AWS/ECR
---
ECRの作成からdocker push まで一貫してterraformで行えるようにする

プライベートリポジトリは月500MBまで、パブリックは50GBまで無料利用できる
パブリックとプライベートの違い、課金方法の違いがわからない
[Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)
→`aws_ecr_repository` で作成されるECRレポジトリはプライベート

[【HCL】TerraformでECRへPushする #AWS - Qiita](https://qiita.com/wwalpha/items/4a3e4f1f54e896633c01)

[The terraform\_data Managed Resource Type | Terraform | Hash...](https://developer.hashicorp.com/terraform/language/resources/terraform-data)
terraform_data はnull_resourceの代替として使える

以下のようにterraformファイルを作る
ECR -> docker push -> lambda 作成になるようにdepends_on を用意しておく
```hcl
resource "aws_ecr_repository" "example_lambda_repo" {
  name = "example_lambda_repo"
}

resource "terraform_data" "push_image" {
  depends_on = [ aws_ecr_repository.example_lambda_repo ]

  provisioner "local-exec" {
    // ローカルのスクリプトを呼び出す
    command = "sh ${path.module}/push_image.sh"

    // スクリプト専用の環境変数
    environment = {
      AWS_REGION     = var.aws_region
      AWS_ACCOUNT_ID = local.aws_account_id
      REPO_URL       = aws_ecr_repository.example_lambda_repo.repository_url
    }
  }
}

resource "aws_lambda_function" "example_lambda_repo_function" {
  depends_on = [ terraform_data.push_image ]
  ...
```

push_image.sh
```bash
#!/bin/bash

# Docker login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build image
# docker build -t $CONTAINER_NAME .

# Tag
docker tag anitunes:1.5 $REPO_URL:latest

# Push image
docker push $REPO_URL:latest
```

下記がdocker imageをpushするまでの一連の流れ
```bash
# まずログイン
%> aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin xxxuseridxxx.dkr.ecr.ap-northeast-1.amazonaws.com

%> docker tag anitunes:1.5 "xxxuseridxxx.dkr.ecr.ap-northeast-1.amazonaws.com/example_lambda_repo"

%> docker push "109026126473.dkr.ecr.ap-northeast-1.amazonaws.com/example_lambda_repo"
```
タグをつけるときにバージョンをつけない場合はlatestが使用される
また、ECRのコンソールからURIをコピーできるので、これをそのままコピペで良い

なぜか get-loginが成功しているはずなのに上手く行かない
ローカルで自分で叩くと上手くいく
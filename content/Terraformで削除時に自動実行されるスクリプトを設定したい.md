---
tags:
  - AWS
  - Terraform
---

Terraformで削除時に自動実行されるスクリプトを設定したい
[Provisioners | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax#destroy-time-provisioners)

when = destroy
を指定することで削除時にimageの削除も行えるようにする

```hcl
  provisioner "local-exec" {
    when    = destroy
    command = "aws ecr batch-delete-image --repository-name example_lambda_repo --image-ids imageTag=latest"
  }
```
destroyの中で変数展開は出来ない模様
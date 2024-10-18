---
tags:
  - Terraform
  - AWS/lambda
---
terraformでlambdaをデプロイする際に環境変数を設定

```hcl
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_role.arn
  filename      = "lambda_function_payload.zip"

  # 環境変数の設定
  environment {
    variables = {
      VAR_NAME1 = "value1"
      VAR_NAME2 = "value2"
    }
  }
}
```
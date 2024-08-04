---
tags:
  - AWS
---

assume role とは何なのか？
直接ポリシーをアタッチするのと違ってなにが嬉しいのか？
[イラストで理解するAssumeRoleの疑問](https://zenn.dev/fdnsy/articles/e98c43d9c3f611)
[AssumeRoleを駆使して強大な権限を持つIAMユーザやアクセスキーを撲滅し...](https://qiita.com/odayushin/items/4f85f381a5906a2320ab)

つまり、assume roleで誰がそのロールの権限を使えるようになるのかを決め、実際のロールの権限の詳細に関してはポリシーで制御する、という感じ

より具体的な例を示します。ここでは、Lambda関数がS3バケット内のオブジェクトを読み取るためのIAMロールを設定するケースを考えます。この例では、IAMロールを作成し、そのロールに必要な権限を付与し、Lambdaサービスがそのロールを引き受けることを許可します。

### 具体例: LambdaがS3バケットからオブジェクトを読み取る

#### IAMロールの作成とAssume Roleポリシーの設定

```hcl
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
```

このコードは、`lambda_exec_role`というIAMロールを作成し、Lambdaサービスがこのロールを引き受けることを許可しています。

#### S3へのアクセス権限を持つIAMポリシーの作成

次に、このIAMロールにS3へのアクセス権限を付与します。
```hcl
resource "aws_iam_policy" "lambda_s3_access" {
  name        = "lambda_s3_access"
  description = "Allows Lambda functions to access S3 objects"

  policy = data.aws_iam_policy_document.lambda_s3_policy.json
}

data "aws_iam_policy_document" "lambda_s3_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::my-example-bucket/*",
    ]
  }
}
```
このポリシーは、指定されたS3バケット（`my-example-bucket`）内のオブジェクトを読み取る権限をLambda関数に付与します。

#### IAMロールにポリシーをアタッチ

最後に、このポリシーを先ほど作成したIAMロールにアタッチします。

```hcl
resource "aws_iam_role_policy_attachment" "lambda_s3_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_s3_access.arn
}
```
このコードは、`lambda_s3_access`ポリシーを`lambda_exec_role`ロールにアタッチし、Lambda関数がS3バケットのオブジェクトにアクセスできるようにします。

#### Lambda関数の設定

最後に、このIAMロールを使用するLambda関数を作成します。
```hcl
resource "aws_lambda_function" "my_lambda_function" {
  function_name = "MyExampleFunction"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  # Zip file containing your Lambda function code
  filename      = "path/to/lambda-function.zip"
}
```
この設定では、`my_lambda_function`という名前のLambda関数を作成し、`lambda_exec_role`をこの関数にアタッチしています。これにより、Lambda関数はS3バケットからオブジェクトを読み取ることができるようになります。

### まとめ

1. **IAMロールの作成**: `lambda_exec_role`を作成し、`assume_role_policy`でLambdaサービスがこのロールを引き受けることを許可します。
    
2. **S3アクセス用ポリシーの作成**: `lambda_s3_access`ポリシーを作成し、Lambda関数がS3バケット内のオブジェクトを読み取ることを許可します。
    
3. **ポリシーのアタッチ**: 作成したポリシーをIAMロールにアタッチします。
    
4. **Lambda関数の作成**: IAMロールを使用するLambda関数を作成し、必要なリソースへのアクセスを許可します。
    

この構成により、Lambda関数は指定されたS3バケット内のオブジェクトを読み取ることができるようになります。`assume_role_policy`は、LambdaがこのIAMロールを引き受ける際に必要な設定であり、リソースへのアクセスを制御する基本的な仕組みです。

IAMロールにおける`assume_role_policy`と、IAMポリシーでのアクセス許可は異なる役割を果たしています。それぞれの役割と、なぜ両方が必要なのかについて詳しく説明します。

### IAMロールとAssume Roleポリシーの役割

1. **Assume Roleポリシー**:
    
    - `assume_role_policy`は、特定のAWSサービス（この場合はLambda）がこのIAMロールを引き受けることを許可するためのものです。
    - `identifiers = ["lambda.amazonaws.com"]`は、Lambdaサービスにこのロールを引き受ける権限を与えるための設定です。この設定がなければ、Lambda関数はこのロールを引き受けることができません。
2. **IAMポリシーのアクセス許可**:
    
    - IAMポリシー（`lambda_s3_policy`）は、引き受けたロールが具体的に何をすることができるかを定義します。
    - `s3:GetObject`のようなアクションを許可することで、引き受けたロールを持つエンティティ（この場合はLambda関数）がS3バケットのオブジェクトを取得できるようにします。

### なぜ両方が必要なのか？

- **Assume Roleポリシーだけでは不十分**:
    
    - `assume_role_policy`が設定されていなければ、Lambda関数はそもそもこのIAMロールを引き受けることができず、結果としてIAMポリシーで許可されたアクション（例: `s3:GetObject`）を実行することができません。
- **IAMポリシーだけでは不十分**:
    
    - IAMポリシーでどんなに多くの権限を定義しても、`assume_role_policy`によって適切なエンティティがロールを引き受けることを許可されていなければ、それらの権限は利用されません。

### まとめ

- **Assume Roleポリシー**は、Lambdaサービスが特定のIAMロールを引き受けるための許可を設定します。このポリシーにより、LambdaがそのIAMロールを使用することが可能になります。
- **IAMポリシー**は、そのロールを引き受けたエンティティが具体的にどのリソースにどのようなアクションを実行できるかを定義します。

したがって、Lambda関数がS3バケットにアクセスするには、`assume_role_policy`でLambdaがロールを引き受けることを許可し、その後IAMポリシーでS3バケットへのアクセス権限を付与するという両方のステップが必要です。これにより、Lambda関数がセキュアにS3バケットからオブジェクトを取得できるようになります。
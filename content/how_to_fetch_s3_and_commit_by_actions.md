---
tags:
  - AWS
  - githubActions
---
chatGPTの回答
https://chatgpt.com/share/eed9c1b0-1370-413f-a4ae-2a26fc284052

```yaml
name: Fetch and Commit S3 Data

on:
  schedule:
    - cron: '0 0 * * *' # 毎日0時に実行
  workflow_dispatch: # 手動トリガー

jobs:
  fetch_and_commit:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v3

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v2
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-east-1 # 必要に応じてリージョンを変更

    - name: Fetch data from S3
      run: aws s3 sync s3://your-s3-bucket/path/to/data ./local/path

    - name: Commit changes
      run: |
        git config --global user.name 'github-actions'
        git config --global user.email 'github-actions@github.com'
        git add .
        git commit -m 'Update data from S3'
        git push origin main
```

まずは
1. #obsidian のremotely syncでAWSに現在のファイルを同期してみる
2.  githubで、AWSからDataをfetchして自分でコミットさせる
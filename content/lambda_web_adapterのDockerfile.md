---
tags:
  - AWS/lambda
  - Docker
  - Cloud
  - lambda_web_adapter
---
next js lambda web adapterの動作確認
https://github.com/awslabs/aws-lambda-web-adapter/tree/main/examples/nextjs

```dockerfile
FROM public.ecr.aws/docker/library/node:20.9.0-slim as builder
WORKDIR /app
COPY . .
RUN npm ci && npm run build

FROM public.ecr.aws/docker/library/node:20.9.0-slim as runner
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.4 /lambda-adapter /opt/extensions/lambda-adapter
ENV PORT=3000 NODE_ENV=production
ENV AWS_LWA_ENABLE_COMPRESSION=true
WORKDIR /app
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/run.sh ./run.sh
RUN ln -s /tmp/cache ./.next/cache

CMD exec ./run.sh
```

おそらく下記2つが重要
```dockerfile
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.4 /lambda-adapter /opt/extensions/lambda-adapter

ENV AWS_LWA_ENABLE_COMPRESSION=true
```

AniTunesで動かすには、3つのハードルを超える必要がある
- production環境でのDockerfile作成
- Dockerfileの書き換え
- AWS SAMをTerraformに書き換え

chatGPTのTerraform書き換え結果は以下
https://chatgpt.com/share/0bde2035-a93b-4b6f-a649-ecf1e2550b3f

以下のコマンドで動くと書いてあるが動かない
```
sam build
sam deploy --guided
```

ついでにローカルでのテストも500エラー

---
tags:
  - Docker
---
debian : alpine
gosu -> su-exec

apt-get install --no-install -> apk add --no-cache

debianでは getent, usermod, groupmodが使えるので
alpine では shadow 不要

# Dockerfile例

## debian
```dockerfile
FROM public.ecr.aws/docker/library/node:20.9.0-slim
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.4 /lambda-adapter /opt/extensions/lambda-adapter

WORKDIR /app

# Next.js collects completely anonymous telemetry data about general usage. Learn more here: https://nextjs.org/telemetry
# Uncomment the following line to disable telemetry at run time
# ENV NEXT_TELEMETRY_DISABLED 1

RUN apt-get update && apt-get install -y --no-install-recommends \
  gosu

# ビルド時、 UID 1000 の node が存在する
# entrypointで UID/GID の変更を行うため、root でないと実行できない
# そのため USER 命令は定義しない
# USER node
ARG EXEC_USER=node

ENV USER=$EXEC_USER
ENV HOME=/home/$EXEC_USER

COPY docker/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["npm", "run", "dev"]

```

## alpine
```dockerfile
FROM node:20-alpine

WORKDIR /app

# Next.js collects completely anonymous telemetry data about general usage. Learn more here: https://nextjs.org/telemetry
# Uncomment the following line to disable telemetry at run time
# ENV NEXT_TELEMETRY_DISABLED 1

RUN apk add --no-cache \
  su-exec \
  shadow

# ビルド時、 UID 1000 の node が存在する
# entrypointで UID/GID の変更を行うため、root でないと実行できない
# そのため USER 命令は定義しない
# USER node
ARG EXEC_USER=node

ENV USER=$EXEC_USER
ENV HOME=/home/$EXEC_USER

COPY docker/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["npm", "run", "dev"]

```
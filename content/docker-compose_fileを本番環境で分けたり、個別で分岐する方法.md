---
tags:
  - Docker
---

docker-compose_fileを本番環境で分けたり、個別で分岐する方法
docker-compose fileはproductionとdevで分岐できるのか？
```
$ docker compose -f docker-compose-prod.yml build
```
上記のコマンドでcompose fileを指定可能
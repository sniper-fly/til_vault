---
tags:
  - Docker
  - mysql
---
mysqlのDockerコンテナで日本語入力ができないときの対処法
[DockerのMySQLで日本語が使えない！？](https://tech.anti-pattern.co.jp/docker-no-mysql-de-japanese/)

これを追加するだけ
```Dockerfile
RUN apt-get update && apt-get install -y locales  
RUN sed -i -E 's/# (ja\_JP.UTF-8)/\\1/' /etc/locale.gen && locale-gen  
ENV LANG ja\_JP.UTF-8
```
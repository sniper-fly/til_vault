---
tags:
  - Cloud
  - Docker
---
docker compose file内で変数を定義して使い回す方法
[docker-compose.ymlの中で値を使い回す方法｜TechRacho by BPS株式会社](https://techracho.bpsinc.jp/hachi8833/2020_02_07/87447)
yamlの機能でなんとかできる
`x-` で始まるキーを定義することでDocker composeが無視される
&アンカー名 で書いて *アンカー名 とすることで参照できる
```yaml
x-var: &BUNDLER_VERSION
  2.1.2

services:
  app: &app
    build:
	  ...
	  args:
		BUNDLER_VERSION: *BUNDLER_VERSION
	...
```

`<<`を使うことで複数の値のセットをまとめて展開することも出来る
```yaml
x-common-environment: &common-environment
  MYSQL_ROOT_PASSWORD: dev
  MYSQL_DATABASE: dev
  MYSQL_USER: dev
  MYSQL_PASSWORD: dev
  MYSQL_PORT: 3306

	...
    environment:
      MYSQL_HOST: db
      <<: *common-environment
```

>The `<<:` syntax is a merge key in YAML, which allows you to merge the contents of one mapping into another.

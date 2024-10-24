---
tags:
  - nginx
  - ISUCON
---

nginxでのURLパスとディレクトリ名のパスに差異があるときのaliasによる対応方法について

最初にイメージがあるかどうかを確かめるディレクトリは /home/isucon/private_isu/webapp/public/image/ ではなく /home/isucon/private_isu/webapp/public/img であった場合、どのように書き換えれば良い？
### 解説：

```nginx
location /image/ {
  alias /home/isucon/private_isu/webapp/public/img/;
  expires 1d;
  try_files $uri @app;
}

location @app {
  internal;
  proxy_pass http://localhost:8080;
}
```
1. **`alias`**
    - `alias`ディレクティブを使うと、`/image/` に対するリクエストは `alias`で指定されたディレクトリに直接マップされます。この場合、`/image/logo.png` に対するリクエストは、`/home/isucon/private_isu/webapp/public/img/logo.png` にマッピングされます。
この修正により、ディレクトリの正しい参照が可能になります。
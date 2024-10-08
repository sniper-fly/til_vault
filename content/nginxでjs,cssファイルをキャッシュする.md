---
tags:
  - ISUCON
  - nginx
---

nginxでjs,cssファイルをキャッシュする
js, cssファイルは静的なので基本的にキャッシュしてもよい

nginxでの設定例
```
location /css/ {
	root /home/isucon/private_isu/webapp/public/;
}
location /js/ {
	root /home/isucon/private_isu/webapp/public/;
}
```
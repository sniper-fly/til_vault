---
tags:
  - nginx
  - ISUCON
---

private-isuでnginxが出すlogをjson形式にする
/etc/nginx/nginx.conf にlog_formatを設定してもダメだった
http server等のcontextの中でしか使えない
[Module ngx\_http\_log\_module](https://nginx.org/en/docs/http/ngx_http_log_module.html#example)

デフォルトのログ方法だと、ただlog_formatを追加するだけだと既存のログ方法にプラスしてjsonのログが追加される形式になってしまう

そこで
`/etc/nginx/sites-enabled/isucon.conf`
を以下のように設定する
```
log_format json escape=json '{"time":"$time_iso8601",'
	'"host":"$remote_addr",'
	'"port":$remote_port,'
	'"method":"$request_method",'
	'"uri":"$request_uri",'
	'"status":"$status",'
	'"body_bytes":$body_bytes_sent,'
	'"referer":"$http_referer",'
	'"ua":"$http_user_agent",'
	'"request_time":"$request_time",'
	'"response_time":"$upstream_response_time"}';

server {
  listen 80;

  client_max_body_size 10m;
  root /home/isucon/private_isu/webapp/public/;

  location / {
    proxy_set_header Host $host;
    proxy_pass http://localhost:8080;
  }

  access_log /var/log/nginx/access.log json;
}
```
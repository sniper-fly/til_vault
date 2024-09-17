---
tags:
  - bash
  - shellScript
---

githubのrawファイルダウンロードは、元ファイルが
`https://github.com/tatsujin-web-performance/tatsujin-web-performance/blob/main/chapter-4/accounts.js`
のようなurlだとすると、
`https://raw.githubusercontent.com/tatsujin-web-performance/tatsujin-web-performance/main/chapter-4/accounts.js`
になる

ドメインが`raw.githubusercontent.com` になったうえに、`blob`が消える
githubのファイルURLパスからrawファイルをcurlでダウンロードする
URL変換してダウンロードする処理は以下
```bash
#!/bin/bash

# 引数で渡されたURLを変換する
getgitrawfile() {
    local url=$1
    # URLを変換する
    local new_url=$(echo "$url" | sed 's#https://github.com/#https://raw.githubusercontent.com/#' | sed 's#/blob/#/#')
    curl -O $new_url
}

# 変換対象のURLを受け取る
if [ -z "$1" ]; then
    echo "Usage: $0 <github-url>"
    exit 1
fi

getgitrawfile "$1"
```
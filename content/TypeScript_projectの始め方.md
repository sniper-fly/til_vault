---
tags:
  - typescript
  - nodejs
---
```json
{
  "name": "helloworld",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "ts-node": "^10.9.2"
  },
  "dependencies": {
    "@types/node": "^22.0.0",
    "typescript": "^5.5.4"
  }
}

```

https://github.com/axios/axios/issues/5909
@types/node がないとエラーになったりする
上記の3つのパッケージは必要そう

スクリプトを実行する際は
```
npx ts-node hoge.ts
```

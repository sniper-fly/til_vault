---
tags:
  - typescript
---

typescriptでログファイルに日付,時刻情報を文字列出力する

標準ライブラリだけで済ます場合
```ts
const now = new Date();

// 年月日時分を2桁にするための関数
const padZero = (num: number) => num.toString().padStart(2, '0');

// 年月日と時刻をフォーマット
const year = now.getFullYear().toString().slice(2);
const month = padZero(now.getMonth() + 1);
const day = padZero(now.getDate());
const hours = padZero(now.getHours());
const minutes = padZero(now.getMinutes());

const filename = `logs/${year}${month}${day}${hours}${minutes}.json`;

console.log(filename); // logs/2408181035.json のような形式
```

sprintf-jsを使う場合
```ts
import { sprintf } from "sprintf-js";

const now = new Date();
const filename = sprintf("logs/%02d%02d%02d%02d%02d.json", 
    now.getFullYear() % 100, // 年の最後の2桁
    now.getMonth() + 1,      // 月は0始まりなので+1する
    now.getDate(),
    now.getHours(),
    now.getMinutes()
);

console.log(filename); // logs/2408181035.json のような形式

```

writeFileSyncはディレクトリが存在しない場合エラーになる
ディレクトリを再帰的に作るにはmkdirSyncを使う
```ts
const filename = "logs/2408181035.json";

// ファイルのディレクトリパスを取得
const dir = path.dirname(filename);

// ディレクトリが存在しない場合に作成する
fs.mkdirSync(dir, { recursive: true })
```
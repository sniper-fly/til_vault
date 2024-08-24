---
tags:
  - typescript
---

typescriptでのエラーログの簡易的な残し方、ファイル書き出し方法
```ts
import * as fs from "fs";

const err = e as Error;
console.error(e);
const errorLog = {
  anime: anime,
  animeTheme: animeTheme,
  error: err,
  message: err.message,
  stack: err.stack,
};
fs.writeFileSync(
  `logs/errorLog.json`,
  JSON.stringify(errorLog, null, 2)
);
```
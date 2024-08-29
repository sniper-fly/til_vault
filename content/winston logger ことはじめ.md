---
tags:
  - typescript
---

winston logger ことはじめ
[GitHub - winstonjs/winston: A logger for just about everythi...](https://github.com/winstonjs/winston)
winston logger

下記のような形でロギングをはじめられる
```ts
import { createLogger, format, transports } from "winston";

export const logger = createLogger({
  level: "info",
  format: format.combine(
    format.timestamp({ format: "YYYY-MM-DD HH:mm:ss" }),
    format.errors({ stack: true }),
    format.splat(),
    format.json()
  ),
  defaultMeta: { service: "anisong" },
  transports: [
    new transports.File({ filename: "logs/error.log", level: "error" }),
    new transports.File({ filename: "logs/combined.log" }),
  ],
});
```

`format.splat()`
この設定があることで、下記のようにprintfスタイルでロギングが出来るようになる
```ts
logger.log('info', 'test message %d', 123);
```

`level: "info"`
info以下のレベルのログが記録される
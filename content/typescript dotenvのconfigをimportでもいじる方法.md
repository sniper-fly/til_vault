---
tags:
  - typescript
---

typescript dotenvのconfigをimportでもいじる方法
.env.animeを追加している例
```ts
import * as dotenv from "dotenv";

dotenv.config({ path: [".env", ".env.anime"] });
```
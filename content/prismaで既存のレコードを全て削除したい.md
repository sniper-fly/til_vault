---
tags:
  - typescript/prisma
---

prismaで既存のレコードを全て削除したい
```
npx prisma migrate reset
```

If you use Prisma Migrate, you can use the `migrate reset` command. This will drop the database, create a new one, apply migrations, and seed the database with data.
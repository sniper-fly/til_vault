---
tags:
  - typescript/prisma
---

prismaで作ったレコードにupdatedAtやcreatedAtを追加する方法
[How to migrate from Sequelize to Prisma ORM | Prisma Documen...](https://www.prisma.io/docs/orm/more/migrating-to-prisma/migrate-from-sequelize#timestamps)
自分で追加しないとダメ

```ts
model User {
  id        Int      @id @default(autoincrement())
  name      String?
  email     String   @unique
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}
```
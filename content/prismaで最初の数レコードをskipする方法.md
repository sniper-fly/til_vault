---
tags:
  - typescript/prisma
---

prismaで最初の数レコードをskipする方法
[Pagination (Reference) | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-client/queries/pagination)
skipで指定した数だけレコードを飛ばせる
```ts
const results = await prisma.post.findMany({
  skip: 3,
  take: 4,
  orderBy: {
    id: 'asc'
  }
})
```
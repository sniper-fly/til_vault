---
tags:
  - typescript/prisma
---

prismaでDBに格納できる文字列の長さを指定する方法
`@db.VarChar(x)` を使う
[Prisma Schema API | Prisma Documentation](https://www.prisma.io/docs/orm/reference/prisma-schema-reference#mysql)
```
model SpotifyTrack {
  id               String          @id @db.VarChar(25) // uri
  ...
}
```
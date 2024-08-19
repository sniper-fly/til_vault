---
tags:
  - typescript/prisma
---

Prismaで複合主キーを設定する
[Prismaで複合主キーを設定する](https://zenn.dev/kaz_z/articles/prisma-unique-key)
こんな感じで定義可能
```
model Student {
  id        Int     @id @default(autoincrement())
  grade     Int
  group     Int
  number    Int
  name      String

  @@unique([grade, group, number], name: "studentIdentifier")
}
```
Q.これでupsertの際の条件指定に出来るか？
A.もちろん可能。一意に絞り込む系で何でも使用可能になる
```ts
const student = await prisma.student.findUnique({
  where: {
    student_identifier: {
      grade: 1,
      group: 1,
      number: 1,
    },
  },
})
```
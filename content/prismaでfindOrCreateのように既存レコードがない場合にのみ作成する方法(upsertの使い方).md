---
tags:
  - typescript/prisma
---

prismaでfindOrCreateのように既存レコードがない場合にのみ作成する方法(upsertの使い方)
[upsert | CRUD (Reference) | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-client/queries/crud#update-or-create-records:~:text=Prisma%20Client%20does%20not%20have%20a%20findOrCreate()%20query.%20You%20can%20use%20upsert()%20as%20a%20workaround.%20To%20make%20upsert()%20behave%20like%20a%20findOrCreate()%20method%2C%20provide%20an%20empty%20update%20parameter%20to%20upsert().)
> Prisma Client does not have a findOrCreate() query. You can use upsert() as a workaround. To make upsert() behave like a findOrCreate() method, provide an empty update parameter to upsert().
findOrCreate的なメソッドがないので、レコードがなければ作成、というのを実現したい場合はupdateを空にして実行する
```ts
await prisma.user.upsert({
  where: { email: record.email },
  update: {},
  create: {
	email: record.email,
	name: record.name,
  },
});
```
丁度こんな感じ
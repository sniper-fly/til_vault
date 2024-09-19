---
tags:
  - typescript/prisma
---

prismaでupdateの際にオブジェクトの代わりにundefinedを渡すと？
> Using `undefined` as the value of any key in a Prisma Client query's parameter object will cause Prisma ORM to act as if that key was not provided at all.
 
この性質を利用して、3項演算子と併用することでundefinedの時に何もしないように出来る
```ts
  await prisma.aPSong.upsert({
    where: { id: song.id },
    update: {
      anime: animeId && { connect: { id: animeId } },
    },
    create: {
		...
    },
```
[Null and undefined (Reference) | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-client/special-fields-and-types/null-and-undefined#undefined)
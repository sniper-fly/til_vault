---
tags:
  - typescript/prisma
---

prismaでupdateする際のconnectの挙動について
```ts
await prisma.aPSong.upsert({
    where: { id: 7104 },
    update: {
      anime: { connect: { id: 22 } },
    },
    create: {
      id: 7104,
      type: "Opening",
      title: "From The Seeds",
      anime: { connect: { id: 21 } },
      seasonInfo: "Spring 2020"
    },
  });
```
create時に上記のような形で新たにデータを作った場合、
update時にconnectで指定を行うと今までの関連が削除されるのではなく、新たに追加される
（apSong hasMany anime であるため）
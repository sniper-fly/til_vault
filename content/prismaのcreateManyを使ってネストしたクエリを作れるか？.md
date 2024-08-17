---
tags:
  - tryAndError
  - typescript/prisma
---

prismaのcreateManyを使ってネストしたクエリを作れるか？

```ts
  const createMany = await prisma.anime.createMany({
    data: json.map((record) => ({
      id: record.id,
      anilistId: record.resources.find((r) => r.site === "AniList")
        ?.external_id,
      myanimelistId: record.resources.find((r) => r.site === "MyAnimeList")
        ?.external_id,
      kitsuId: record.resources.find((r) => r.site === "Kitsu")?.external_id,
      anidbId: record.resources.find((r) => r.site === "aniDB")?.external_id,
      title: record.name,
      animeThemes: {
        create: record.animethemes.map((theme) => {
          const song = theme.song;
          return {
            id: theme.id,
            title: song.title,
            slug: theme.slug,
            artists: {
              create: song.artists.map((artist) => ({
                id: artist.id,
                name: artist.name,
              })),
            },
          };
        }),
      },
    })),
    skipDuplicates: true,
  });
```

下記エラーが発生する。
```
Unknown argument `animeThemes`. Available options are marked with ?.
```
[Relation queries (Concepts) | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-client/queries/relation-queries#create-multiple-records-and-multiple-related-records)
> you cannot create multiple users and multiple posts in a single nested write.

こういった場合は1個1個insertするか、1:m の1の側を一気に作ってあとから関連付ける手もある

## connectOrCreate とはどう使える？

結論：createMany 関数の中では、connectは使えない
[How to use connect inside createMany ? · prisma/prisma · Dis...](https://github.com/prisma/prisma/discussions/18963)

```
Can I use createMany and connectOrCreate at the same time?

No, you cannot use `createMany` and `connectOrCreate` at the same time in a top-level query. According to the Prisma documentation and various discussions, you cannot nest `create`, `createMany`, `connect`, or `connectOrCreate` inside a top-level `createMany` query.

Here are some relevant points from the knowledge sources:

1. **Prisma Documentation on `createMany`**:
    
    - "You **cannot** create or connect relations by using nested `create`, `createMany`, `connect`, `connectOrCreate` queries inside a top-level `createMany()` query." [Source](https://www.prisma.io/docs/orm/reference/prisma-client-reference#createmany)
```

connectOrCreateを使って、関連するレコードがDBに存在していた場合は作成しないようにできる
但し複数の関連を一度に作成する場合は使えない

#####  Is it possible to create multiple records by using connectOrCreate in nested writes?
No, it is not currently possible to create multiple records using `connectOrCreate` in nested writes directly. The `connectOrCreate` method is designed to handle a single record at a time.
However, you can achieve this by using a loop to iterate over the records you want to create and applying `connectOrCreate` to each one individually.

##### Example: Using a Loop to Create Multiple Records with `connectOrCreate`
Here is an example of how you can use a loop to create multiple records with `connectOrCreate`:
```ts
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function createMultipleRecords() {
  const records = [
    { email: 'user1@example.com', name: 'User 1' },
    { email: 'user2@example.com', name: 'User 2' },
    { email: 'user3@example.com', name: 'User 3' },
  ];

  for (const record of records) {
    await prisma.user.upsert({
      where: { email: record.email },
      update: {},
      create: {
        email: record.email,
        name: record.name,
      },
    });
  }
}

createMultipleRecords()
  .catch(e => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
```

upsertの使い方に関しては以下も
[[prismaでfindOrCreateのように既存レコードがない場合にのみ作成する方法(upsertの使い方)]]


##### Official Guidance
According to the [official answer](https://github.com/prisma/prisma/discussions/18505) from the Prisma team, an array can be passed in a nested `createMany` call, but not in a nested create query. They recommend invoking a create query inside a loop to create multiple records.

[Relation queries (Concepts) | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-client/queries/relation-queries#add-new-related-records-to-an-existing-record)

## updateとの組み合わせについて
createManyがネストされたオブジェクトの中で使えるのはupdateの中だけ

##  多対多のリレーションをどうすれば上手く作れるのか
skipDuplicatesを存分に利用して一度に大量のデータ挿入するのが最もクエリ回数が少なく効率的
その場合、createManyでは関連するテーブルのデータまでまとめて作成ができないため、１種類ずつ、テーブルのクエリを作成する必要がある
多対多のリレーションを表現する場合は中間テーブル(join table)のcreateManyが必要になるが、implicit m-m テーブルは直接のcreateManyができないので、その手法をとる場合はschema.prismaでexplicit m-m テーブルの作成を行う必要がある
ただし今回の場合、自分の環境で一回DBを作れば完了なので、速度はそこまで気にする必要はなさそう
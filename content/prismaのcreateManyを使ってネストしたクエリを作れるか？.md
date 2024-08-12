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
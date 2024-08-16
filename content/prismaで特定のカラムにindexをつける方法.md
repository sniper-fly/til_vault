---
tags:
  - typescript/prisma
---

prismaで特定のカラムにindexをつける方法
[Indexes | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-schema/data-model/indexes)
```
model AnimeTheme {
  id             Int                @id // animetheme api's song id
  title          String
  slug           String
  artists        AnimeThemeArtist[]
  spotifySongs   SpotifySong[]
  appleMusicUrls AppleMusicUrl[]
  animeId        Int
  anime          Anime              @relation(fields: [animeId], references: [id])
  createdAt      DateTime           @default(now())
  updatedAt      DateTime           @updatedAt

  @@index([createdAt, updatedAt])
}
```
カラム名を配列に入れるだけ
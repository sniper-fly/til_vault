---
tags:
  - SQL
  - typescript/prisma
  - tryAndError
---
外部キーの参照先を用意せずにテーブルを作成しようとした時のエラー(Cannot add or update a child row: a foreign key constraint fails)
myanimelistIdを外部キーとして使おうとしたら以下のエラー

```
model Anime {
  id            Int          @id // animetheme api's anime id
  anilistId     Int?
  myanimelistId Int?         

  >>>>>
  myanimelist   MyAnimeList? @relation(fields: [myanimelistId], references: [id])
  >>>>>
  
  kitsuId       Int?
  anidbId       Int?
  title         String
  animeThemes   AnimeTheme[]
  createdAt     DateTime     @default(now())
  updatedAt     DateTime     @updatedAt
  apSongs       APSong[]

  @@index([anilistId, myanimelistId, kitsuId, anidbId, createdAt, updatedAt])
}
```

```
Database error code: 1452

Database error:
Cannot add or update a child row: a foreign key constraint fails (`dev`.`#sql-1_34`, CONSTRAINT `Anime_myanimelistId_fkey` FOREIGN KEY (`myanimelistId`) REFERENCES `MyAnimeList` (`id`) ON DELETE SET NULL ON UPDATE CASCADE)
```

考えられる原因
**参照しているレコードが存在しない**:
- `Anime`テーブルの`myanimelistId`カラムに入力された値が、`MyAnimeList`テーブルの`id`カラムに存在しない場合、このエラーが発生します。`myanimelistId`に正しい`MyAnimeList`の`id`を設定するか、新しい`MyAnimeList`のレコードを作成してから`Anime`テーブルに挿入を試みてください。

既にAnimeテーブルには沢山のレコードがある
MyAnimeListにレコードを追加してから外部キー制約を足すようにする

migrationファイルで不要な部分を消して再実行しようとすると以下のエラー
```
- The migration `20240827085343_add_mal_data_table` failed.
- The migration `20240827085343_add_mal_data_table` was modified after it was applied.
```
ムカついたので、`_prisma_migrations`テーブルから該当のログレコードを削除、マイグレーションファイルを削除してなかったことにした

[Generating down migrations | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-migrate/workflows/generating-down-migrations#how-to-apply-your-down-migration-to-a-failed-migration)
production databaseの戻し方について色々書いてあったがよくわからん
結局手動でtable をdropした

[Patching & hotfixing | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-migrate/workflows/patching-and-hotfixing#fixing-failed-migrations-with-migrate-diff-and-db-execute)
こっちのほうが正しい？

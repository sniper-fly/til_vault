---
tags:
  - typescript/prisma
  - tryAndError
---
prismaで外部キーをuniqueにしているとき、prisma migrateしても変更を検知しない（手動でマイグレーションファイルを作る方法）

migrateしても変化なし
[removing \`@unique\` in \`schema.prisma\` does not generate ...](https://github.com/prisma/prisma/issues/12732)

これはOSSコミットできるチャンスなのでは？

まず一時的に`SpotifyTrack_apSongId_fkey`を削除
`SpotifyTrack_apSongId_key` インデックスを削除。
`SpotifyTrack_apSongId_fkey`を再追加
これはマイグレーションファイルを参考にする
```sql
-- 一時的に外部キー制約を解除
ALTER TABLE
  `SpotifyTrack` DROP FOREIGN KEY `SpotifyTrack_apSongId_fkey`;

-- delete unique index
ALTER TABLE
  `SpotifyTrack` DROP INDEX `SpotifyTrack_apSongId_key`;

-- AddForeignKey
ALTER TABLE
  `SpotifyTrack`
ADD
  CONSTRAINT `SpotifyTrack_apSongId_fkey` FOREIGN KEY (`apSongId`) REFERENCES `APSong`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
```
---
tags:
  - SQL
  - typescript/prisma
---

hasOne relationを利用するメリット
- nullを避けられる
例えば、一つの曲Songテーブルがあったとして、その曲はSpotifyのリンクがあったり、
AppleMusicのリンクがあったり、どちらか片方、もしくは両方持っているような場合がある。

このとき、Songテーブルに全ての情報をカラムに載せた場合、applemusicの情報、spotifyの情報を全てnullableにしなければならない。
```
model Song {
  id            Int            @id @default(autoincrement())
  type          String
  title         String

// applemusic
  url       String?

// spotify
  name             String?
  previewUrl       String?
  image            String?
  durationMs       Int?
  isrc             String?
  
  createdAt     DateTime       @default(now())
  updatedAt     DateTime       @updatedAt
}
```

これをhasOneで定義した場合、本当に必要な箇所のみnullableにできる。
これによってDBの安全性が向上する。
```
model Song {
  id            Int            @id @default(autoincrement())
  type          String
  title         String
  appleMusicUrl AppleMusicUrl?
  spotifyTrack  SpotifyTrack?
  createdAt     DateTime       @default(now())
  updatedAt     DateTime       @updatedAt
}

model AppleMusicUrl {
  id        Int      @id @default(autoincrement())
  url       String
  songId    Int      @unique
  song      Song     @relation(fields: [apSongId], references: [id])
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

model SpotifyTrack {
  id               String        @id @db.VarChar(25) // uri
  name             String
  previewUrl       String?
  image            String
  durationMs       Int
  isrc             String?
  songId           Int           @unique
  song             Song          @relation(fields: [apSongId], references: [id])
  createdAt        DateTime      @default(now())
  updatedAt        DateTime      @updatedAt
}
```

- 余計なupdateAtの更新を避けられる
addedTimesという、例えば誰かにその曲が再生された場合に加算するカラムがあったとする。
この時、updateAtももちろん更新されてしまう。
ただし、固定値を格納しているDBの場合、updatedAtが特別な意味を持つことがある。
あまり頻繁にテーブルのupdateAtを更新してほしくない場合、頻繁に変わるカラムのみhasOneでテーブルを分割するという方法もある。
```
model SpotifyTrack {
  id               String        @id @db.VarChar(25) // uri
  name             String
  previewUrl       String?
  image            String
  durationMs       Int
  isrc             String?
  songId           Int           @unique
  song             Song          @relation(fields: [apSongId], references: [id])

  playedTimes      Int
  
  createdAt        DateTime      @default(now())
  updatedAt        DateTime      @updatedAt
}
```

デメリット
- 結合が多くなる
結合が多くなるためパフォーマンスの低下を招く可能性がある
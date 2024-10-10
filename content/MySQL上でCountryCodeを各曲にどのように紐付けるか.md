---
tags:
  - personalProject
---

MySQL上でCountryCodeを各曲にどのように紐付けるか

Spotifyの曲データには、その曲が利用可能な国の一覧が
ISO 3166-1 alpha-2の形式でstring配列として保存されています。

例えば、日本とアメリカでのみ視聴可能な曲の場合は、
```ts
["US", "JP"]
```
のように格納されています。

曲の情報をデータベースに入れるにあたって、１つのカラムで曲の視聴可能地域の情報を格納することは可能でしょうか？また、この場合の良いアプローチについて教えてください。

### 1. **カンマ区切りの文字列として保存**
### 2. **JSON配列として保存**
### 3. **別テーブルに国情報を分ける (正規化)**
### 4. **ビットマスクの使用**

[ChatGPT - 曲視聴地域データ管理](https://chatgpt.com/share/6707dccd-e0b0-8005-8f08-d47a4a5245ea)
詳しいメリデメ比較は上記。

当初は文字列ビットマスクが良さそうだと考えていたが、Json管理の方法が柔軟性、可読性、データ操作、データの空間効率で最も優れていると判断。
(最も柔軟且つインデックスの利用が可能なのは正規化。)

[Working with Json fields (Concepts) | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-client/special-fields-and-types/working-with-json-fields)
prisma mysqlでもJsonに対応している
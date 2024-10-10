---
tags:
  - typescript/prisma
---

prismaのJson型カラムで、配列が特定の値を含むレコードを抽出する
[Filtering on an array value | Working with Json fields (Concepts) | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-client/special-fields-and-types/working-with-json-fields#filtering-on-an-array-value)

仮に以下のようなデータ構造のカラムがあったとき、
```json
["Claudine", "Sunny"]
```

`Claudine`を含むレコードを検索するには
```ts
const getUsers = await prisma.user.findMany({
  where: {
    extendedPetsData: {
      array_contains: ['Claudine'],
    },
  },
})
```

[array_contains | Prisma Client API | Prisma Documentation](https://www.prisma.io/docs/orm/reference/prisma-client-reference#array_contains)
複数の値を含むことを条件として検索も可能
```ts
const getUsers = await prisma.user.findMany({
  where: {
    pets: {
      path: ['sanctuaries'],
      array_contains: ['RSPCA', 'Alley Cat Allies'],
    },
  },
})
`
---
tags:
  - typescript/prisma
---

schema.prismaのリレーション名変更はDBを変更せずに可能
[Introspection with Prisma ORM, TypeScript, and PostgreSQL | ...](https://www.prisma.io/docs/getting-started/setup-prisma/add-to-existing-project/relational-databases/introspection-typescript-postgresql)
relationの名前に関してはDBに触らずに変更可能
>Because [relation fields](https://www.prisma.io/docs/orm/prisma-schema/data-model/relations#relation-fields) are _virtual_ (i.e. they _do not directly manifest in the database_), you can manually rename them in your Prisma schema without touching the database:

下記コマンドでschema.prismaの内容をTypeとして反映できる
```
npx prisma generate
```
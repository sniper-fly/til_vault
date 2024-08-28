---
tags:
  - typescript/prisma
---

Prismaで複合キーを定義した時にデフォルトでつけられるidentifierの名前は？
What is the default identifier name of the composite key below?
```
@@unique([malId, type, title])
```

The default identifier name of the composite key @@unique([malId, type, title]) will be malId_type_title.

just concatenated
[ define a unique field | Models | Prisma Documentation](https://www.prisma.io/docs/orm/prisma-schema/data-model/models#defining-a-unique-field)
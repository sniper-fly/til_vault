---
tags:
  - typescript
  - Zenn
---
## 要するに...
こういう型から
```ts
export type User_Anime_ListQuery = {
  __typename?: "Query";
  MediaListCollection?: {
    __typename?: "MediaListCollection";
    lists?: Array<{
      __typename?: "MediaListGroup";
      entries?: Array<{
        __typename?: "MediaList";
        media?: {
          __typename?: "Media";
          id: number;
          title?: {
            __typename?: "MediaTitle";
            native?: string | null;
            romaji?: string | null;
            english?: string | null;
          } | null;
          coverImage?: {
            __typename?: "MediaCoverImage";
            extraLarge?: string | null;
            large?: string | null;
          } | null;
        } | null;
      } | null> | null;
    } | null> | null;
  } | null;
};
```

こういう型を部分的に取り出したい
```ts
type Media = {
  __typename?: "Media";
  id: number;
  title?: {
    __typename?: "MediaTitle";
    native?: string | null;
    romaji?: string | null;
    english?: string | null;
  } | null;
  coverImage?: {
    __typename?: "MediaCoverImage";
    extraLarge?: string | null;
    large?: string | null;
  } | null;
};
```

## 結論
自作のユーティリティ型を使うことで解決
```ts
type extractTypeName<T, __typename> = T extends
  | {
      [key in string]?: infer U;
    }
  | Array<infer U>
  ? U extends { __typename?: __typename }
    ? U
    : extractTypeName<U, __typename>
  : never;

export type Media = extractTypeName<User_Anime_ListQuery, "Media">;
```

## 解説
### 経緯
[AniList](https://anilist.co/home)という自分のアニメリストを作ることができるサービスがあり、
GraphQLのAPIが公開されています。
[Introduction | AniList APIv2 Docs](https://anilist.gitbook.io/anilist-apiv2-docs)

[Codegen with GraphQL, Typescript, and Apollo - GraphQL Tutor...](https://www.apollographql.com/tutorials/lift-off-part1/09-codegen)
`@graphql-codegen/cli`を使うことでGraphQLクエリの戻り値の型を自動生成出来ます。

例えば、以下のような、ユーザーが持っているアニメリストを取得する
GraphQLのクエリから型を自動生成すると、
```ts
const USER_ANIME_LIST = gql(`
  query USER_ANIME_LIST($userName: String!) {
    MediaListCollection(userName: $userName, type: ANIME) {
      lists {
        entries {
          media {
            id
            title {
              native
              romaji
              english
            }
            coverImage {
              extraLarge
              large
            }
          }
        }
      }
    }
  }
`);
```

以下のような型が得られます。
```ts
export type User_Anime_ListQuery = {
  __typename?: "Query";
  MediaListCollection?: {
    __typename?: "MediaListCollection";
    lists?: Array<{
      __typename?: "MediaListGroup";
      entries?: Array<{
        __typename?: "MediaList";
        media?: {
          __typename?: "Media";
          id: number;
          title?: {
            __typename?: "MediaTitle";
            native?: string | null;
            romaji?: string | null;
            english?: string | null;
          } | null;
          coverImage?: {
            __typename?: "MediaCoverImage";
            extraLarge?: string | null;
            large?: string | null;
          } | null;
        } | null;
      } | null> | null;
    } | null> | null;
  } | null;
};
```

これだけでも便利なのですが、例えば取得した情報の中には配列が含まれており、
要素一つ一つについて処理を行う関数を作りたい場合、上記`User_Anime_ListQuery`から
`__typename?: "Media";`を持つオブジェクトの型を部分的に取り出したくなるということがあります。

愚直に取り出したい型をコピペして利用しても良いですが、例えばGraphQLのクエリを変更した場合は自動生成される型も変更されるため、コピペが多ければ多いほど保守が大変になります。

また、`User_Anime_ListQuery["MediaListCollection"]["lists"]` のようにすることで部分的な型を取り出すことも今回に関しては出来ません。オブジェクトがundefinedやnullを取りうる可能性があるためです。

そこで下記のユーティリティ型を定義します。
```ts
type extractTypeName<T, __typename> = T extends
  | {
      [key in string]?: infer U;
    }
  | Array<infer U>
  ? U extends { __typename?: __typename }
    ? U
    : extractTypeName<U, __typename>
  : never;
```

### 原理
前半部分は`infer`を利用してプロパティ、もしくは配列の型の取り出しを行っています　。
```ts
type extractTypeName<T, __typename> = T extends
  | {
      [key in string]?: infer U;
    }
  | Array<infer U>
```
実はTypeScriptのGeneric Typesでは再帰を使うことが出来ます。
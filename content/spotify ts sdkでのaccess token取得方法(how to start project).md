---
tags:
  - typescript
---

spotify ts sdkでのaccess token取得方法(how to start project)
AniTunesの/hoge でsearch song を押す
開発者ツールのApplicationで`spotify-sdk:AuthorizationCodeWithPKCEStrategy:token`
という場所があるので、こちらで取得する
あとは、CLIENT_IDを環境変数等から取得して下記のようにすればapiの認証が出来る
```ts
  const api = SpotifyApi.withAccessToken(process.env.SPOTIFY_CLIENT_ID!, {
    access_token: process.env.SPOTIFY_ACCESS_TOKEN!,
    token_type: "Bearer",
    expires_in: 3600,
    refresh_token: process.env.SPOTIFY_REFRESH_TOKEN!,
  });
```
ただ、これだと10分しか使えないので、refreshしないといけない
ブラウザと共同するタイプだとブラウザが勝手に更新してくれるが、サーバーサイドスクリプトだと面倒

検索API等の結果の精度は悪いが、URI検索はどのルートでも同じなので下記が一番楽
```ts
  const api = SpotifyApi.withClientCredentials(
    process.env.NEXT_PUBLIC_SPOTIFY_CLIENT_ID!,
    process.env.SPOTIFY_CLIENT_SECRET!
  );
```
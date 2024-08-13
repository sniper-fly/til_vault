---
tags:
  - tryAndError
  - typescript
  - playwright
  - Docker
---

playwrightをDockerで動かすには？
[Docker | Playwright](https://playwright.dev/docs/docker#build-your-own-image)
```
npx -y playwright@1.46.0 install --with-deps
```
上記のコマンドをイメージビルド時に追加する必要がある
ただ、ディレクトリをマウントしている場合はまた話が変わってくる

コンテナの起動時に上記のコマンドを実行するか、
もしくはplaywrightを動かす専用のイメージを使って、そちらにprismaを入れるほうが楽そう
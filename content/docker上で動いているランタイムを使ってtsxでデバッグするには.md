---
tags:
  - tryAndError
  - typescript
  - Docker
---

docker上で動いているランタイムを使ってtsxでデバッグするには
[VS Code debugging | tsx](https://tsx.is/vscode#setup)
こちらが参考になるが、ローカルで実行していないので微妙に使えない

[Debug an app running in a Docker container](https://code.visualstudio.com/docs/containers/debug-common#_nodejs)
[Build and run a Node.js app in a container](https://code.visualstudio.com/docs/containers/quickstart-node#_debug-in-the-service-container)
vscodeの公式記事
requirements にprelaunch taskとしてdockerコンテナを起動すること、が挙げられている
既に起動しているコンテナのランタイムを利用するやり方はないのか？
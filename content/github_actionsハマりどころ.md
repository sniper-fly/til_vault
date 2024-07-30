---
tags:
  - githubActions
---
if: ステートメントではシングルクォートしか使えない
ダブルクォートは使えない

```yaml
if: env.git_changed
```
文字列が存在している場合にのみtrueになってほしいが、こういう条件は使えない
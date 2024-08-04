---
tags:
  - React/react-testing-library
  - test/vitest
  - tutorial
---
以下のチュートリアルを進めてわかったことを書く
https://www.robinwieruch.de/react-testing-library/

it は別に describe の中になくてもよい
RSpecと似ている

screen.debug で実際のHTML構造を把握可能

```
Property 'toBeInTheDocument' does not exist on type 'Assertion<HTMLElement>'
```

import { describe, it, expect } from 'vitest';

これをしなくてもテストは通る
だが、vscodeの静的解析でエラーになってしまい鬱陶しい

[Property 'toBeInTheDocument' does not exist on typ...](https://github.com/testing-library/jest-dom/issues/546#issuecomment-2142356024)
import "@testing-library/jest-dom";
を全てのtsテストファイルに入れるしか解決できる方法がなかった

[How to Fix the "Cannot find name 'describe'" Error...](https://medium.com/@tariibaba/typescript-cannot-find-name-describe-b72f3009ea86)
tsconfigのinclude, excludeは設定しておいた方が良さそう
productionビルド時に余計な型が入ってしまいそう
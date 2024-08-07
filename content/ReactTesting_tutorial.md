---
tags:
  - React/react-testing-library
  - test/vitest
  - tutorial
---
以下のチュートリアルを進めてわかったことを書く
[React Testing Library Tutorial](https://www.robinwieruch.de/react-testing-library/)

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
```ts
import "@testing-library/jest-dom";
```
を全てのtsテストファイルに入れるしか解決できる方法がなかった

[How to Fix the "Cannot find name 'describe'" Error...](https://medium.com/@tariibaba/typescript-cannot-find-name-describe-b72f3009ea86)
tsconfigのinclude, excludeは設定しておいた方が良さそう
productionビルド時に余計な型が入ってしまいそう


`getByText` 以外にも色々

`getByRole`
アクセシブルネームの要素が存在するかをチェックする
例えば、textbox
厳密にテキストが存在するか、ではなくロールベースでHTMLのセマンティクスに沿ったテストができる
これにより、テスト専用のidをつけたりなどをしなくて済む

下記のように空のroleを検索することで、その画面で利用可能なロール一覧を見ることが出来る
```ts
screen.getByRole('')
```

implicit -> 暗黙
explicit -> 明示的

getBy
queryBy
findBy
これらがsearch variants

getByは取得に失敗した時にエラーを出す副作用がある
これは便利だが、例えば存在すべきでないテキストを確かめる時に不便
```ts
    expect(screen.getByText(/Searches for JavaScript/)).toBeNull();
```
このようなユースケースではqueryByが使える

async await, つまりpromiseが関わる場合はfindByを使う
useEffect内でsetStateしたときに、再描画されるのでそれを観測してテストする

但し、待ち時間が長すぎると失敗する
```tsx
  React.useEffect(() => {
    const loadUser = async () => {
      // 5秒待つ
      await new Promise((resolve) => setTimeout(resolve, 5000));
      const user = await getUser();
      setUser(user);
    };

    loadUser();
  }, []);
```

また、以下のように2回描画する場合でも、promiseが関わらなければfindByは不要
```tsx
  React.useEffect(() => {
    setUser({ id: '1', name: 'Robin' });
  }, []);
```


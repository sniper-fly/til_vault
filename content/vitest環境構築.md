---
tags:
  - React
  - test
---

vitest環境構築
https://www.robinwieruch.de/vitest-react-testing-library/

npm i vitest -D
ののち
    "test": "vitest",
スクリプトをpackage.jsonに設定

npm i jsdom -D
https://stackoverflow.com/questions/72146352/vitest-defineconfig-test-does-not-exist-in-type-userconfigexport

vite.config.tsを下記のように書き換える
```ts
import { defineConfig } from "vitest/config";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  test: {
    environment: "jsdom",
  },
});
```

[[ReactTesting_tutorial]] に
`Property 'toBeInTheDocument' does not exist on type 'Assertion<HTMLElement>'`
の解決法を記載

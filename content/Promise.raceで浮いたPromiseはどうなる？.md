---
tags:
  - typescript
  - tryAndError
---

Promise.raceで浮いたPromiseはどうなる？
メモリリークになる？
```ts
import { wait } from "../utils";

async function main() {
  let notifyAsFinal: () => void;
  const finalResponseCompleted = new Promise<void>((resolve) => {
    notifyAsFinal = resolve;
  });

  console.log("start");
  wait(1000).then(() => {
    console.log("notifyAsFinal");
    notifyAsFinal();
  });

  await Promise.race([
    finalResponseCompleted,
    wait(5000).then(() => console.log("timeout")),
  ]);
  console.log("end");
  return;
}

(async () => {
  await main();
})();
```
raceによって処理はキャンセルされるが、関数は5秒経たないと終わらない
関数はmapped typeではどう振る舞う？
```ts
const testfn = () => 10
type mapped<T> = { [key in keyof T]: T[key]}
type test1 = mapped<typeof testfn> // {}
```
ただの空の配列になる
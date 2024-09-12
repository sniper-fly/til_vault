`keyof T extends never` が意味するところ
[typescript - what is "extends never" used for? - Stack Overf...](https://stackoverflow.com/questions/68693054/what-is-extends-never-used-for/68693367)
TがObjectの場合は keyof Object の値が存在しないため、neverとなりextendsがtrueになる
ちなみに、
```ts
type test2 = keyof ({ a: string } | { a: string, b: string })
```
これは共通する"a"が得られる

Mapped typesはprimitiveな型を無視する
```ts
type Look<T> = { [K in keyof T]: 123 } | number;
type Y1 = Look<{ a: string }> // {a: 123}
type Y2 = Look<string> // string
```
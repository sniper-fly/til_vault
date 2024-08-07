---
tags:
  - cpp
---

C++デストラクタ、コンストラクタ
デストラクタの定義
```cpp
  ~node() {}
```

引数付きコンストラクタでデフォルトコンストラクタを再利用したい
```cpp
  node() : parent(NIL), left(NIL), right(NIL) {}
  node(int key) : node() { this->key = key; }
```
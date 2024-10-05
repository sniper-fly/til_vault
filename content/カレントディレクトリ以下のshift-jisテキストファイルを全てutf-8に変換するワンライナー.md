---
tags:
  - shell
  - shellScript
---

カレントディレクトリ以下のshift-jisテキストファイルを全てutf-8に変換するワンライナー

`for file in *; do iconv -f SHIFT_JIS -t UTF-8 "$file" -o "${file%.txt}_utf8.txt"; done`

- `for file in *`: カレントディレクトリのすべてのファイルを対象にループを回します。

- `iconv -f SHIFT_JIS -t UTF-8 "$file" -o "${file%.txt}_utf8.txt"`: ファイルをShift-JISからUTF-8に変換し、元のファイル名に`_utf8`を追加した新しいファイルに保存します。
`${file%.txt}`は拡張子`.txt`を除いたファイル名を指し、ファイルが`.txt`形式でない場合でも動作しますが、`_utf8`がつく形になります。

- 元のファイルを上書きしたい場合、以下のように書き換えます。
`iconv -f SHIFT_JIS -t UTF-8 "$file" -o "$file"`
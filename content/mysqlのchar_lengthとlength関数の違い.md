---
tags:
  - mysql
---

mysqlのchar_lengthとlength関数の違い

https://leetcode.com/problems/invalid-tweets/solutions/968440/mysql-length-is-incorrect-important-difference-between-char-length-vs-length/
で出題

[string - MySQL - length() vs char\_length() - Stack Overflow](https://stackoverflow.com/questions/1734334/mysql-length-vs-char-length?rq=1)
lengthはバイト単位で文字列の長さを測る
char_lengthは文字単位
なので日本語などはlengthだと「あ」が3とかになったりする可能性がある
---
tags:
  - CSS
  - TailwindCSS
---
space-xxxとgapの違い
gapはflexアイテム内でしか使えない
spaceは`> * + *`で指定された子要素に対して使えるため、flexboxでなくても使える
flexboxにするほどではないけど、子要素間のスペースを調整したい、といった場合に便利
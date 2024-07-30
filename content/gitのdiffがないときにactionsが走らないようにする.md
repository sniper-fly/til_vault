---
tags:
  - githubActions
  - shell
---

https://zenn.dev/snowcait/articles/18c9137f49e378
何かファイルが変更されたときにのみ、特定のactionを実行する

if命令が使える

特殊な標準出力をすることであとからsteps.xxx のようにif文で利用できたりする
```
echo "::set-output name=count::$(git diff --name-only | wc -l)"
```

https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/
set-outputはdeprecateになり、environment filesを使う方法にupgradeされるべし
以下のようにして使う
```
echo "{any_name}={any_value}" >> $GITHUB_OUTPUT
```

修正すると以下のようになる

```yml
    - name: check for changes
      id: git_diff
      run: |
        git add .
        echo "{count}={$(git diff --name-only --staged | wc -l)}" >> $GITHUB_OUTPUT

    - name: Commit changes
      if: steps.git_diff.outputs.count > 0
      run: |
        git config --global user.name 'github-actions'
        git config --global user.email 'github-actions@github.com'
        git add .
        git commit -m 'Sync data with S3'
        git push origin v4
```
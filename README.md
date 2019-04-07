# config
vim、fish、tmuxなどの設定ファイル置き場です。

## Introduction

### aliasの設定
`$HOME`以下に必要なエイリアスを張ります。

```sh
./makealiases.sh
```

### homebrew

```bash
cat Brewfile | grep -v "#" | parallel "echo brew {}" | parallel {}
```

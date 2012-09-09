# config
Emacs、zsh、screenなどの設定ファイル置き場です。

## Introduction

### alias

初めに

```sh
./makealiases.sh
```

を実行してください。`$HOME`以下に必要なエイリアスを張ります。

### submodule

たくさんのsubmoduleに依存しています。

```sh
git submodule init && git submodule update
```

を実行すると依存しているファイルを取得してきます。

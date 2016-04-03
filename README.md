# config
Emacs、zsh、screenなどの設定ファイル置き場です。

## Introduction

### oh-my-zshのインストール

初めに

```sh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
```

でoh-my-zshをインストールしてください。

### Emacsのインストール

```sh
brew tap railwaycat/emacsmacport
brew install emacs-mac --with-modern-icon
brew linkapps emacs-mac
```

### aliasの設定
`$HOME`以下に必要なエイリアスを張ります。

```sh
./makealiases.sh
```

### homebrew

```bash
cat Brewfile | grep -v "#" | parallel "echo brew {}" | parallel {}
```

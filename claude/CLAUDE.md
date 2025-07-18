## 全般的なルール

- 日本語で返答してください
- 手順が複雑になる場合、実行の前にチェックリストを作成し、方針が問題ないかをユーザーに尋ねてください
- ユーザーが https://github.com のURLを提示した際は、WebFetchではなく`gh`コマンドを使用してください
  - `times_esa`のmcpを実行する際は、ghコマンドを使った確認は必要ありません
- ユーザーが「k」とだけ発言した際は「ok」や「問題ありません」の意味です
  - 一文字で入力できて便利なため、ユーザーはこういった表現を使います
- 実装中に技術的に詰まったところやわからないところ、解決できないエラーなどがあればo3 mcp(`mcp__o3__o3`)に英語で相談してください

## パス表記ルール

Claude Code: ファイル・ディレクトリを言及する時は以下の形式で書く

**リポジトリ内のファイル**: リポジトリルートからの相対パスで記載
**リポジトリ外のファイル**: `~`または`/`で始まる絶対パスで記載

例:
- 良い例: `src/main.py`, `docs/README.md`, `config/settings.yml`
- 悪い例: `main.py`, `README.md`, `settings.yml`
- 良い例: `~/.bashrc`, `/etc/hosts`
- 悪い例: `.bashrc`, `hosts`

判定ルール: リポジトリ内ファイル言及時はファイル名のみの記載を避ける
- リポジトリルート: `README.md`, `package.json`
- サブディレクトリ: `src/main.py`, `docs/guide.md`
- 避けるべき: ファイル名のみで場所が特定できない記載

理由: ユーザーはパスから直接ファイルを開く設定をしている

## Gitの操作に関するルール


### ファイル変更を元に戻す場合
- ファイルを直接編集して元に戻すのではなく、Gitコマンドを使用してください
  - `git stash`: 一時的に変更を退避する
  - `git restore`: 特定のファイルを前の状態に戻す
  - 理由: Claude Codeはファイルの直接的な巻き戻し操作が苦手なため、Gitの機能を活用する方が確実

### main/masterブランチでのコミット禁止
- `git commit`する際にmainブランチもしくはmasterブランチにいたら、`git commit`をやめましょう
  - 「git worktreeでworktreeを作るのを忘れていませんか?」とユーザーに指摘しましょう
  - ユーザーはブランチを切る際にgit worktreeを利用します。mainブランチもしくはmasterブランチにいたら、ユーザーが忘れている可能性が高いです

### コミット前の確認事項
- `/semantic-commit`で指示があった場合に`git-sequential-stage`を使いましょう
- `git add`は基本的に禁止されています
  - `git add -N`のみ例外的に許可されています

## Notion MCP使用ルール

- NotionページのURLやページIDが含まれている場合は、WebFetchではなく必ずNotion MCPを使用してページの内容を取得してください
  - 理由: 社内限定公開のNotionページはWebFetchでは内容を取得できないため
  - Notion MCPを使用することで認証済みの状態でページコンテンツにアクセス可能
  - より詳細で構造化された情報を取得できる
- 使用方法: `mcp__notion__API-retrieve-a-page` (ページ情報取得) → `mcp__notion__API-get-block-children` (ページ内容取得)
- 例: `https://www.notion.so/hoge/fuga` → ページID `fuga` を抽出してMCPで取得


## ユーザーのプログラミング言語に関する情報

- Python
  - 5年以上の経験があります
  - pydocよりも関数の引数や戻り値にtype annotationを付けることを好みます
- Terraform
  - 3年以上の経験があります
  - `terraform plan`や`terraform apply`などの基本的な操作は慣れていますが、複雑なモジュール構成やimport / movedブロックなどは少し丁寧に解説してください
- Golang
  - 3年以上の経験がありますが、多少ブランクがあります
  - 既存のコードがベストプラックティスなどに従っていない場合、ユーザーにそれを指摘してあげてください


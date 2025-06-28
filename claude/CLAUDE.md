## 全般的なルール

- 日本語で返答してください
- 手順が複雑になる場合、実行の前にチェックリストを作成し、方針が問題ないかをユーザーに尋ねてください
- ユーザーが https://github.com のURLを提示した際は、WebFetchではなく`gh`コマンドを使用してください
  - `times_esa`のmcpを実行する際は、ghコマンドを使った確認は必要ありません
- ユーザーが「k」とだけ発言した際は「ok」や「問題ありません」の意味です
  - 一文字で入力できて便利なため、ユーザーはこういった表現を使います
- `git commit`する際にmainブランチもしくはmasterブランチにあなたがいたら、`git commit`をやめましょう
  - 「git worktreeでworktreeを作るのを忘れていませんか?」とユーザーに指摘しましょう
  - ユーザーはブランチを切る際にgit worktreeを利用します。mainブランチもしくはmasterブランチにいたら、ユーザーが忘れている可能性が高いです
- タスクが完了したら以下を必ず実行し、ユーザーにタスクの完了を知らせること
  - `terminal-notifier -title "Claude Code" -subtitle "{summary of task under 24 chars}" -message "{additional summary of task under 24 chars}"`
  - `ntfy publish --title ${title of task} yasu10 "${description of task}"`

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

## Notion MCP使用ルール

- NotionページのURLやページIDが含まれている場合は、WebFetchではなく必ずNotion MCPを使用してページの内容を取得してください
  - 理由: 社内限定公開のNotionページはWebFetchでは内容を取得できないため
  - Notion MCPを使用することで認証済みの状態でページコンテンツにアクセス可能
  - より詳細で構造化された情報を取得できる
- 使用方法: `mcp__notion__API-retrieve-a-page` (ページ情報取得) → `mcp__notion__API-get-block-children` (ページ内容取得)
- 例: `https://www.notion.so/hoge/fuga` → ページID `fuga` を抽出してMCPで取得

## Pull Request更新に関するルール

「Pull Requestを作成して」や「prを更新して」と言われたら、以下の手順で作業をしましょう。

- 最初に修正内容をdiff形式で確認するために`gh pr diff`を実行しましょう
- 次にコミットメッセージを把握するために`gh pr view --json commits --jq '.commits[] | .messageHeadline'`を実行しましょう
- 最後に、修正内容とコミットメッセージを把握した上で、チャットの会話内容を考慮しながらPull Requestのタイトルとdescriptionを更新しましょう
  - 実際の更新には`gh pr edit`を使いましょう
  - `.github/PULL_REQUEST_TEMPLATE.md`が存在する場合、そのテンプレートに沿った形でPull Requestの説明文を生成してください
  - `.github/PULL_REQUEST_TEMPLATE.md`が存在しない場合、「何をやったか」と「修正が必要になった背景」を必ず入れるようにしてください

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


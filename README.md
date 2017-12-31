## 概要

- Phoenixによる投票システムの作例です。
- 今回は『犬派とネコ派の総選挙』という題目で作成しています。
- 現時点では投票処理は未完成で鋭意作成中です。


## 動作環境(バージョン)

- 環境構築の作業手順は[blog](https://github.com/ht0919/blog)を参照して下さい。
  - macOS: 10.13.2
  - PostgreSQL: 10.1
  - Node.js: 9.3.0
  - Elixir: 1.5.3
  - Phoenix: 1.3.0


## 起動方法

- git clone https://github.com/ht0919/phoenix_vote
- cd phoenix_vote
- mix deps.get
- npm install
- mix ecto.create
- mix ecto.migrate
- mix phoenix.server


## 各機能のURL

- 派閥登録 → [http://localhost:4000/entrys](http://localhost:4000/entrys)
- ログイン → [http://localhost:4000/vote](http://localhost:4000/vote)


## 投票プロジェクトの作成手順

- mix phx.new vote
- cd vote
- mix ecto.create
- mix phx.server
- ブラウザで『http://localhost:4000』を表示


## エントリーページ (CRUD)の追加

- mix phx.gen.html User Entry entrys name:string count:integer
- lib/vote_web/router.exの編集
  - 20行目に『resources "/entrys", EntryController』を追加
- mix ecto.migrate
- mix phx.server
- ブラウザで『http://localhost:4000/vote』を表示


## 投票ページ (index)の追加

1. ルートの追加
  - lib/vote_web/router.exの編集
    - 20行目に『get "/vote", VoteController, :index』を追加
2. コントローラーの追加
  - lib/vote_web/controllers/vote_controller.ex
3. ビューの追加
  - lib/vote_web/views/vote_view.ex
4. テンプレートの追加
  - lib/vote_web/templates/vote/index.html.exx
5. 動作確認
  - ブラウザで『http://localhost:4000/vote』を表示

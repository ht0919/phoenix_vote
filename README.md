## 概要

- Phoenixによる投票システムの作例です。
- 今回は『犬派と猫派の総選挙』という標題で作成しています。


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
- mix phx.server


## 各機能のURL

- 派閥登録 → [http://localhost:4000/entrys](http://localhost:4000/entrys)
- ログイン → [http://localhost:4000/vote](http://localhost:4000/vote)

## 実行時のイメージ

![img01.png](https://raw.githubusercontent.com/ht0919/phoenix_vote/master/images/img01.png)


## 投票プロジェクトの作成手順

- mix phx.new vote
- cd vote
- mix ecto.create
- mix phx.server
- ブラウザで[http://localhost:4000/](http://localhost:4000/)を表示

## エントリーページ (CRUD)の追加

- mix phx.gen.html User Entry entrys name:string count:integer
- lib/vote_web/router.exの編集
  - 20行目に『resources "/entrys", EntryController』を追加
- mix ecto.migrate
- mix phx.server
- ブラウザで[http://localhost:4000/vote](http://localhost:4000/vote)を表示
- 初期データとして「犬派」と「猫派」をそれぞれ0件として登録する

## 投票ページ (index)の追加

- ルートの追加
  - lib/vote_web/router.exの編集
    - 20行目に『get "/vote", VoteController, :index』を追加
    - 21行目に『post "/vote", VoteController, :update』を追加
- Cross Site Forgery Protection エラーの対策
  - lib/vote_web/views/vote_view.exの編集
    - 3行目に『import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]』を追加
- コントローラーの追加
  - lib/vote_web/controllers/vote_controller.ex
- ビューの追加
  - lib/vote_web/views/vote_view.ex
- テンプレートの追加
  - lib/vote_web/templates/vote/index.html.exx
- 動作確認
  - ブラウザで[http://localhost:4000/vote](http://localhost:4000/vote)を表示

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

- git clone https://github.com/ht0919/phoenix_vote.git
- cd phoenix_vote
- mix deps.get
- npm install
- mix ecto.create
- mix ecto.migrate
- cd assets && npm install && cd ..
- mix phx.server


## 各機能のURL

- 派閥登録 → [http://localhost:4000/entrys](http://localhost:4000/entrys)
- 投票ページ → [http://localhost:4000/vote](http://localhost:4000/vote)

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

![img02.png](https://raw.githubusercontent.com/ht0919/phoenix_vote/master/images/img02.png)


## 投票ページ (index)の追加

- ルートの追加
  - lib/vote_web/router.exの編集
    - 20行目に『get "/vote", VoteController, :index』を追加
    - 21行目に『post "/vote", VoteController, :update』を追加
- コントローラーの追加
  - lib/vote_web/controllers/vote_controller.ex

    ```
    defmodule VoteWeb.VoteController do
      use VoteWeb, :controller

      alias Vote.User

      def index(conn, _params) do
        entrys = User.list_entrys()
        render(conn, "index.html", entrys: entrys)
      end

      def update(conn, %{"id" => id}) do
        entry = User.get_entry!(id)
        entry_params = %{ name: entry.name, count: entry.count+1 }
        User.update_entry(entry, entry_params)
        entrys = User.list_entrys()
        render(conn, "index.html", entrys: entrys)
      end

    end
    ```

- ビューの追加(Cross Site Forgery Protection エラー対策)
  - lib/vote_web/views/vote_view.ex

    ```
    defmodule VoteWeb.VoteView do
      use VoteWeb, :view
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]
    end
    ```

- テンプレートの追加
  - lib/vote_web/templates/vote/index.html.exx

    ```
    <h1>犬派か猫派の総選挙</h1>
    <h3>あなたはどっち派？</h3>
    <%= form_tag("/vote", method: :post) %>
      <table border="1" width="320">
        <tr align="center">
          <td>派閥</td><td>投票数</td><td>選択</td>
        </tr>
        <%= for entry <- @entrys do %>
          <tr align="center">
            <td><%= entry.name %></td><td><%= entry.count %></td>
            <td><input type="radio" name="id" value="<%= entry.id %>"></td>
          </tr>
        <% end %>
      </table>
      <input type="submit" value="投票する">
    </form>
    ```

- 動作確認
  - ブラウザで[http://localhost:4000/vote](http://localhost:4000/vote)を表示


## 今後の予定（選挙システムに向けた構想）

- 投票ページのAjax化
  - 投票数のみをAjaxで更新する
- 住民登録機能の追加
  - 選挙に参加するユーザの登録
  - ログイン処理
- 選挙管理機能の追加
  - 選挙の登録
  - 選挙管理人の登録
  - 立候補者の登録
  - 住民への投票チケット発行
  - 重複投票の排除

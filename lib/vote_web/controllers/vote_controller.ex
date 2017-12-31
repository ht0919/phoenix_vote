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

defmodule VoteWeb.PageController do
  use VoteWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

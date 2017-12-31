defmodule VoteWeb.VoteView do
  use VoteWeb, :view
  import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]
end

defmodule VoteWeb.EntryController do
  use VoteWeb, :controller

  alias Vote.User
  alias Vote.User.Entry

  def index(conn, _params) do
    entrys = User.list_entrys()
    render(conn, "index.html", entrys: entrys)
  end

  def new(conn, _params) do
    changeset = User.change_entry(%Entry{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entry" => entry_params}) do
    case User.create_entry(entry_params) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: entry_path(conn, :show, entry))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entry = User.get_entry!(id)
    render(conn, "show.html", entry: entry)
  end

  def edit(conn, %{"id" => id}) do
    entry = User.get_entry!(id)
    changeset = User.change_entry(entry)
    render(conn, "edit.html", entry: entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = User.get_entry!(id)

    case User.update_entry(entry, entry_params) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: entry_path(conn, :show, entry))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = User.get_entry!(id)
    {:ok, _entry} = User.delete_entry(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: entry_path(conn, :index))
  end
end

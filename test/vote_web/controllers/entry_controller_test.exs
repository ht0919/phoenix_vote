defmodule VoteWeb.EntryControllerTest do
  use VoteWeb.ConnCase

  alias Vote.User

  @create_attrs %{count: 42, name: "some name"}
  @update_attrs %{count: 43, name: "some updated name"}
  @invalid_attrs %{count: nil, name: nil}

  def fixture(:entry) do
    {:ok, entry} = User.create_entry(@create_attrs)
    entry
  end

  describe "index" do
    test "lists all entrys", %{conn: conn} do
      conn = get conn, entry_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Entrys"
    end
  end

  describe "new entry" do
    test "renders form", %{conn: conn} do
      conn = get conn, entry_path(conn, :new)
      assert html_response(conn, 200) =~ "New Entry"
    end
  end

  describe "create entry" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, entry_path(conn, :create), entry: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == entry_path(conn, :show, id)

      conn = get conn, entry_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Entry"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, entry_path(conn, :create), entry: @invalid_attrs
      assert html_response(conn, 200) =~ "New Entry"
    end
  end

  describe "edit entry" do
    setup [:create_entry]

    test "renders form for editing chosen entry", %{conn: conn, entry: entry} do
      conn = get conn, entry_path(conn, :edit, entry)
      assert html_response(conn, 200) =~ "Edit Entry"
    end
  end

  describe "update entry" do
    setup [:create_entry]

    test "redirects when data is valid", %{conn: conn, entry: entry} do
      conn = put conn, entry_path(conn, :update, entry), entry: @update_attrs
      assert redirected_to(conn) == entry_path(conn, :show, entry)

      conn = get conn, entry_path(conn, :show, entry)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, entry: entry} do
      conn = put conn, entry_path(conn, :update, entry), entry: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Entry"
    end
  end

  describe "delete entry" do
    setup [:create_entry]

    test "deletes chosen entry", %{conn: conn, entry: entry} do
      conn = delete conn, entry_path(conn, :delete, entry)
      assert redirected_to(conn) == entry_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, entry_path(conn, :show, entry)
      end
    end
  end

  defp create_entry(_) do
    entry = fixture(:entry)
    {:ok, entry: entry}
  end
end

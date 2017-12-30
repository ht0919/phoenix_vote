defmodule Vote.UserTest do
  use Vote.DataCase

  alias Vote.User

  describe "entrys" do
    alias Vote.User.Entry

    @valid_attrs %{count: 42, name: "some name"}
    @update_attrs %{count: 43, name: "some updated name"}
    @invalid_attrs %{count: nil, name: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> User.create_entry()

      entry
    end

    test "list_entrys/0 returns all entrys" do
      entry = entry_fixture()
      assert User.list_entrys() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert User.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = User.create_entry(@valid_attrs)
      assert entry.count == 42
      assert entry.name == "some name"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, entry} = User.update_entry(entry, @update_attrs)
      assert %Entry{} = entry
      assert entry.count == 43
      assert entry.name == "some updated name"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_entry(entry, @invalid_attrs)
      assert entry == User.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = User.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> User.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = User.change_entry(entry)
    end
  end
end

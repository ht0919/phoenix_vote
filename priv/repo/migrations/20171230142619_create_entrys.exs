defmodule Vote.Repo.Migrations.CreateEntrys do
  use Ecto.Migration

  def change do
    create table(:entrys) do
      add :name, :string
      add :count, :integer

      timestamps()
    end

  end
end

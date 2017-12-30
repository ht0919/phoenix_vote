defmodule Vote.User.Entry do
  use Ecto.Schema
  import Ecto.Changeset
  alias Vote.User.Entry


  schema "entrys" do
    field :count, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Entry{} = entry, attrs) do
    entry
    |> cast(attrs, [:name, :count])
    |> validate_required([:name, :count])
  end
end

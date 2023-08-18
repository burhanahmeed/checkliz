defmodule ChecklizWeb.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :slug, :string
    field :name, :string
    field :description, :string
    field :deleted_at, :naive_datetime

    timestamps()
  end

  def changeset(room, attrs \\ %{}) do
    room
    |> cast(attrs, [:name, :slug, :description])
    |> generate_slug()
    |> validate_required([:name, :slug])
  end

  defp generate_slug(changeset) do
    case get_change(changeset, :name) do
      nil -> changeset
      name ->
        slug = name |> String.downcase() |> String.replace(~r/[^a-z0-9]/, "-")
        put_change(changeset, :slug, slug)
    end
  end
end

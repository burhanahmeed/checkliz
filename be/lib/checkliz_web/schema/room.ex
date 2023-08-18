defmodule Checkliz.Room do
  use Ecto.Schema

  schema "rooms" do
    field :id, :integer
    field :slug, :string
    field :name, :string
    field :description, :string
    field :deleted_at, :native_datetime

    timestamps()
  end

  before_insert :generate_slug
  before_update :generate_slug

  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :slug, :description])
    |> validate_required([:name, :slug])
  end

  defp generate_slug(room) do
    slug = room.name |> String.downcase() |> String.replace(~r/[^a-z0-9]/, "-")
    %{room | slug: slug}
  end
end

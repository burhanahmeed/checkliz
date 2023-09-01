defmodule ChecklizWeb.Content do
  use Ecto.Schema

  import Ecto.Changeset

  schema "contents" do
    field :room_id, :integer
    field :parent_id, :integer
    field :type, :string
    field :value, :string
    field :meta, :string
    field :deleted_at, :naive_datetime

    timestamps()
  end

  def changeset(content, attrs \\ %{}) do
    content
    |> cast(attrs, [:room_id, :parent_id, :type, :value, :meta, :deleted_at])
    |> validate_required([:room_id, :type])
  end
end

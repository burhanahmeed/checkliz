defmodule ChecklizWeb.Content do
  use Ecto.Schema

  schema "contents" do
    field :room_id, :integer
    field :parent_id, :integer
    field :type, :string
    field :value, :string
    field :meta, :string
    field :deleted_at, :naive_datetime

    timestamps()
  end
end

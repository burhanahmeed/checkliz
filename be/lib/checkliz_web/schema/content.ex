defmodule Checkliz.Content do
  use Ecto.Schema

  schema "contents" do
    field :id, :integer
    field :room_id, :integer
    field :parent_id, :integer
    field :type, :string
    field :value, :string
    field :meta, :string
    field :deleted_at, :native_datetime

    timestamps()
  end
end

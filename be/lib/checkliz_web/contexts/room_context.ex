defmodule ChecklizWeb.RoomContext do
  alias Checkliz.Repo
  alias ChecklizWeb.Room

  import Ecto.Query

  def get_room(id) do
    Repo.get(Room, id)
  end

  def update_room(room, attrs) do
    Room.changeset(room, attrs)
    |> Repo.update()
  end
end

defmodule ChecklizWeb.RoomContext do
  alias Checkliz.Repo
  alias ChecklizWeb.Room

  import Ecto.Query

  def get_all(search, page, per_page) do
    offset = (page - 1) * per_page
    query =
      from r in Room,
      where: like(r.name, ^"%#{search}%"),
      offset: ^offset,
      limit: ^per_page,
      order_by: [desc: r.id]

    Repo.all(query)
  end

  def get_count_all(search) do
    query =
      from r in Room,
      where: like(r.name, ^"%#{search}%"),
      select: count("*")

    Repo.all(query)
  end

  def get_room(id) do
    Repo.get(Room, id)
  end

  def update_room(room, attrs) do
    Room.changeset(room, attrs)
    |> Repo.update()
  end
end

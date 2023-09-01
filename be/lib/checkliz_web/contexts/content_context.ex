defmodule ChecklizWeb.ContentContext do
  alias Checkliz.Repo
  alias ChecklizWeb.Content

  import Ecto.Query

  def insert_content(content, attrs) do
    Content.changeset(content, attrs) |> Repo.insert()
  end

  def get_content_by_room_id(id) do
    query =
      from c in Content,
      where: c.room_id == ^id,
      order_by: [desc: c.id]

    Repo.all(query)
  end

  def get_content(id) do
    Repo.get(Content, id)
  end

  def update_content(content, attrs) do
    Content.changeset(content, attrs) |> Repo.update()
  end
end

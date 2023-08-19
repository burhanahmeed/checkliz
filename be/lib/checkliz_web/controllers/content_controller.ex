defmodule Checkliz.ContentController do
  use ChecklizWeb, :controller

  alias ChecklizWeb.Content
  alias Checkliz.Repo
  alias Checkliz.ContentContext

  @not_found_message %{
    errors: %{
      message: "Content is not found"
    }
  }

  def get_room_content(conn, %{"room_id" => room_id}) do
    case ContentContext.get_content_by_room_id(room_id) do
      {:ok, contents} ->
        conn
        |> put_status(:ok)
        |> json(%{
          message: "Content for the room were gotten!",
          contents: contents |> Enum.map(fn con -> %{
            room_id: con.room_id,
            parent_id: con.parent_id,
            type: con.type,
            value: con.value,
            meta: con.meta,
            inserted_at: con.inserted_at,
            updated_at: con.updated_at
          } end)
        })
    end
  end

  def create(conn, %{
    "room_id" => room_id,
    "parent_id" => parent_id,
    "type" => type,
    "value" => value,
    "meta" => meta
  }) do
    case ContentContext.insert_content(%Content{}, %{
      "room_id" => room_id,
      "parent_id" => parent_id,
      "type" => type,
      "value" => value,
      "meta" => meta
    }) do
      {:ok, content} ->
        conn
        |> put_status(:ok)
        |> json(%{
          message: "Content has been created!",
          data: %{
            room_id: content.room_id,
            type: content.type,
            value: content.value
          }
        })

        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{errors: changeset.errors})
    end
  end

  def update(conn, %{"id" => id}) do
    content = ContentContext.get_content(id)

    case content do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(@not_found_message)

      content ->
        case  do
          {:ok, updated_content} ->
            conn
            |> put_status(:not_found)
            |> json(@not_found_message)

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: changeset.errors})
        end
    end
  end

  def delete(conn) do
    content = ContentContext.get_content(id)
    case content do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(@not_found_message)

      content ->
        Repo.delete!(content)
        conn
        |> put_status(:ok)
        |> json(%{message: "Content information was deleted!"})
    end
  end
end

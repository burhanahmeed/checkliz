defmodule ChecklizWeb.RoomController do
  use ChecklizWeb, :controller

  alias ChecklizWeb.RoomContext
  alias ChecklizWeb.Room
  alias Checkliz.Repo

  @not_found_message %{
    errors: %{
      message: "Room is not found"
    }
  }

  def index(conn, params) do
    IO.inspect(params)
    per_page = String.to_integer(Map.get(params, "size", "10"))
    page = String.to_integer(Map.get(params, "page", "1"))
    search_term = String.trim(Map.get(params, "search", ""))

    rooms = RoomContext.get_all(search_term, page, per_page)
    count = RoomContext.get_count_all(search_term)

    conn
    |> put_status(:ok)
    |> json(%{
      rooms: rooms |> Enum.map(fn room -> %{
        id: room.id,
        name: room.name,
        description: room.description,
        slug: room.slug,
        inserted_at: room.inserted_at
      } end),
      meta: %{
        total_count: Enum.at(count, 0),
        per_page: per_page,
        current_page: page,
        search: search_term
      }
    })
  end

  def show(conn, %{"id" => id}) do
    room = RoomContext.get_room(id)
    case room do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(@not_found_message)

      room ->
        response = %{
          message: "Room was successfully gotten!",
          data: %{
            id: room.id,
            slug: room.slug,
            name: room.name,
            description: room.description,
            inserted_at: room.inserted_at
          }
        }

        conn
        |> put_status(:ok)
        |> json(response)
    end
  end

  def create(conn, %{"room" => room_params}) do
    changeset = Room.changeset(%Room{}, room_params)

    case Repo.insert(changeset) do
      {:ok, room} ->
        response = %{
          message: "Room has been created!",
          data: %{
            id: room.id,
            name: room.name,
            slug: room.slug,
            desc: room.description
          }
        }

        conn
        |> put_status(:created)
        |> json(response)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset.errors})
    end
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = RoomContext.get_room(id)

    case room do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(@not_found_message)

      room ->
        case RoomContext.update_room(room, room_params) do
          {:ok, updated_room} ->
            response = %{
              message: "Room has been updated!",
              data: %{
                id: updated_room.id,
                name: updated_room.name
              }
            }

            conn
            |> put_status(:ok)
            |> json(response)

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: changeset.errors})
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    room = RoomContext.get_room(id)

    case room do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(@not_found_message)

      room ->
        Repo.delete!(room)
        conn
        |> put_status(:ok)
        |> json(%{message: "Room information was deleted!"})
    end
  end
end

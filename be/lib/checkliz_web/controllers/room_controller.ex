defmodule ChecklizWeb.RoomController do
  use ChecklizWeb, :controller

  alias ChecklizWeb.RoomContext
  alias ChecklizWeb.Room
  alias Checkliz.Repo

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
    room = RoomContext.get_room!(id)

    case room do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{errors: "Room is not found"})

      room ->
        case RoomContext.update_room(room, room_params) do
          {:ok, updated_room} ->
            response = %{
              message: "Room has been created!",
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

  def delete do
    changeset = Room.changeset(%Room{}, room_params)

    case Repo.delete(changeset) do
      {:ok, room} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "Room information was deleted!"})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset.errors})
    end
  end
end

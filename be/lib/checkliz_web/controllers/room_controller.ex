defmodule ChecklizWeb.RoomController do
  use ChecklizWeb, :controller

  alias ChecklizWeb.Room
  alias Checkliz.Repo

  def create(conn, %{"room" => room_params}) do
    changeset = Room.changeset(%Room{}, room_params)

    case Repo.insert(changeset) do
      {:ok, room} ->
        IO.puts(room.description)
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
end

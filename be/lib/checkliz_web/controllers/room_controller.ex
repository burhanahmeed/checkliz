defmodule ChecklizWeb.RoomController do
  use ChecklizWeb, :controller

  alias ChecklizWeb.Room

  def create(conn, %{"room" => room_params}) do
    changeset = Room.changeset(%Room{}, room_params)

    case ChecklizWeb.Room.create!(changeset) do
      {:ok, room} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Room has been created!", room: room})

      {:error, err} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: err.errors})
    end
  end
end

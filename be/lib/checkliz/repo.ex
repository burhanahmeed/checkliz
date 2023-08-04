defmodule Checkliz.Repo do
  use Ecto.Repo,
    otp_app: :checkliz,
    adapter: Ecto.Adapters.MyXQL
end

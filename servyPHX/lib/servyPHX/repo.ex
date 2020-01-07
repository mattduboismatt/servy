defmodule ServyPHX.Repo do
  use Ecto.Repo,
    otp_app: :servyPHX,
    adapter: Ecto.Adapters.Postgres
end

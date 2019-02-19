defmodule Prog.Repo do
  use Ecto.Repo,
    otp_app: :prog,
    adapter: Ecto.Adapters.Postgres
end

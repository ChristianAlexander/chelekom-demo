defmodule ComponentTest.Repo do
  use Ecto.Repo,
    otp_app: :component_test,
    adapter: Ecto.Adapters.Postgres
end

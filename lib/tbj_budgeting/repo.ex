defmodule TbjBudgeting.Repo do
  use Ecto.Repo,
    otp_app: :tbj_budgeting,
    adapter: Ecto.Adapters.Postgres
end

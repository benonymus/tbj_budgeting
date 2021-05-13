defmodule TbjBudgeting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TbjBudgeting.Repo,
      # Start the Telemetry supervisor
      TbjBudgetingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TbjBudgeting.PubSub},
      # Start the Endpoint (http/https)
      TbjBudgetingWeb.Endpoint
      # Start a worker by calling: TbjBudgeting.Worker.start_link(arg)
      # {TbjBudgeting.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TbjBudgeting.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TbjBudgetingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule ComponentTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ComponentTestWeb.Telemetry,
      ComponentTest.Repo,
      {DNSCluster, query: Application.get_env(:component_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ComponentTest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ComponentTest.Finch},
      # Start a worker by calling: ComponentTest.Worker.start_link(arg)
      # {ComponentTest.Worker, arg},
      # Start to serve requests, typically the last entry
      ComponentTestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ComponentTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ComponentTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

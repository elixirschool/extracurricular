defmodule Web.Application do
  @moduledoc """
  The Web Application Service.
  """

  use Application

  alias Web.Endpoint

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Endpoint, []),
      supervisor(Task.Supervisor, [[name: Web.TaskSupervisor, restart: :transient]])
    ]

    opts = [strategy: :one_for_one, name: Web.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end

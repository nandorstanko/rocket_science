defmodule RocketScience.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {RocketScience.ControlCenter, []}
    ]

    opts = [strategy: :one_for_one, name: RocketScience.Application]
    Supervisor.start_link(children, opts)
  end
end

defmodule BikeRank do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(BikeRank.Runner, [])
    ]

    opts = [strategy: :simple_one_for_one, name: BikeRank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def compute do
    runners = spawn_runners([:speed], [])

    BikeRank.Runner.run(runners[:speed], {:kph, 30})

    BikeRank.Runner.get(runners[:speed])
  end

  defp spawn_runners([facet|facets], runners) do
    {:ok, runner} = Supervisor.start_child(BikeRank.Supervisor, [facet])
    spawn_runners(facets, [{facet, runner}|runners])
  end

  defp spawn_runners([], runners) do
    runners
  end
end

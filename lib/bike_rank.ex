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
    facets = [
      [speed: BikeRank.Facet.SpeedLimit, kph: 35]
    ]

    runners = spawn_runners(facets, [])

    run_runners(runners)

    BikeRank.Runner.get(runners[:speed])
  end

  defp spawn_runners([facet|facets], runners) do
    {:ok, runner} = Supervisor.start_child(BikeRank.Supervisor, [facet])
    [{name, _mod}, _params] = facet
    spawn_runners(facets, [{name, runner}|runners])
  end

  defp spawn_runners([], runners) do
    runners
  end

  defp run_runners([runner|runners]) do
    {name, pid} = runner
    BikeRank.Runner.run(pid)
    run_runners(runners)
  end

  defp run_runners([]) do
  end
end

defmodule BikeRank do
  @moduledoc """
  BikeRank analysis for the suitability of a road segment for cycling
  as transportation.
  """

  use Application

  alias BikeRank.Runner, as: Runner

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Runner, [])
    ]

    opts = [strategy: :simple_one_for_one, name: BikeRank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Accepts "facets" like this:

  [[speed: BikeRank.Facet.SpeedLimit, params: [kph: 35]]]

  Where `:speed` is the name of the facet, `BikeRank.Facet.SpeedLimit` is the
  module for the facet, and the remaining term(s) are the params for the
  facet computation.
  """
  @spec compute([[{atom, any}, ...]]) :: [{atom, any}, ...]
  def compute(facets) do
    runners = spawn_runners(facets, [])

    run_runners(runners)

    Runner.get(runners[:speed])
  end

  defp spawn_runners([facet|facets], runners) do
    {:ok, runner} = Supervisor.start_child(BikeRank.Supervisor, [facet])

    [{name, _mod}, params: _params] = facet
    spawn_runners(facets, [{name, runner}|runners])
  end

  defp spawn_runners([], runners) do
    runners
  end

  defp run_runners([runner|runners]) do
    {_name, pid} = runner
    Runner.run(pid)
    run_runners(runners)
  end

  defp run_runners([]) do
  end
end

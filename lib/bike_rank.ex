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
    {:ok, speed} = Supervisor.start_child(BikeRank.Supervisor, [:speed])

    BikeRank.Runner.run(speed, {:kph, 30})
    BikeRank.Runner.get(speed)
  end
end

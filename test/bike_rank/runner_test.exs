defmodule BikeRank.RunnerTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, runner} = BikeRank.Runner.start_link(:foo)
    {:ok, runner: runner}
  end

  test "it runs a facet score computation", %{runner: runner} do
    assert BikeRank.Runner.run(runner, {:kph, 30}) == :ok
  end

  test "it gets a facet score that already exists", %{runner: runner} do
    BikeRank.Runner.run(runner, {:kph, 30})
    assert BikeRank.Runner.get(runner) == {:foo, {:kph, 30}}
  end
end

defmodule BikeRank.Runner.FooFacet do
  def score(_) do
    100
  end
end

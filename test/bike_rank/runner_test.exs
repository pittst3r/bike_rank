defmodule BikeRank.RunnerTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, facet} =
      BikeRank.Runner.start_link(foo: BikeRank.Runner.FooFacet, kph: 30)
    {:ok, facet: facet}
  end

  test "it runs a facet score computation", %{facet: facet} do
    assert BikeRank.Runner.run(facet) == :ok
  end

  test "it gets a facet score that already exists", %{facet: facet} do
    BikeRank.Runner.run(facet)
    assert BikeRank.Runner.get(facet) ==
      [score: 100, foo: BikeRank.Runner.FooFacet, kph: 30]
  end
end

defmodule BikeRank.Runner.FooFacet do
  def score(_) do
    100
  end
end

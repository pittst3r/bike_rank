defmodule BikeRankTest do
  use ExUnit.Case
  doctest BikeRank.Runner

  test "computes score on arbitrary module" do
    rando_facet_run = [BikeRank.Facet.CoolFacet, {:asdf, 30}]
    assert BikeRank.Runner.run(rando_facet_run) == {:ok, 100}
  end
end

defmodule BikeRank.Facet.CoolFacet do
  def score({:asdf, 30}) do
    {:ok, 100}
  end
end

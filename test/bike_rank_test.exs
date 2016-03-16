defmodule BikeRankTest do
  use ExUnit.Case, async: true

  test "it computes" do
    assert BikeRank.compute([[speed: BikeRank.Facet.SpeedLimit, params: [kph: 35]]]) ==
      [score: 75, speed: BikeRank.Facet.SpeedLimit, params: [kph: 35]]
  end
end

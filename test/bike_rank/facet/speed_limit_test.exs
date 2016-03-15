defmodule SpeedLimitTest do
  use ExUnit.Case
  doctest BikeRank.Facet.SpeedLimit

  test "assigns score to speed limit" do
    assert BikeRank.Facet.SpeedLimit.score({:kph, 30}) == 100
    assert BikeRank.Facet.SpeedLimit.score({:mph, 20}) == 100

    assert BikeRank.Facet.SpeedLimit.score({:kph, 110}) == 0
    assert BikeRank.Facet.SpeedLimit.score({:mph, 80}) == 0
  end
end

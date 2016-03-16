defmodule BikeRank.Facet.SpeedLimit do
  @moduledoc """
  Computes the facet's score given a certain speed limit.
  """

  @behaviour BikeRank.Facet

  def score(kph: speed_limit) do
    case speed_limit do
      s when s <= 30 -> 100
      s when s <= 40 -> 75
      s when s <= 50 -> 50
      s when s <= 70 -> 25
      s when s >  71 -> 0
    end
  end

  def score({:mph, speed_limit}) do
    case speed_limit do
      s when s <= 20 -> 100
      s when s <= 25 -> 75
      s when s <= 30 -> 50
      s when s <= 45 -> 25
      s when s >  45 -> 0
    end
  end
end

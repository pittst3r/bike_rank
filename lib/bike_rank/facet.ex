defmodule BikeRank.Facet do
  @moduledoc """
  Behaviours for facets.
  """

  @callback score([{atom, any}, ...]) :: number
end

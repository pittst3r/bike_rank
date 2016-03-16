defmodule BikeRank.Runner do
  @moduledoc """
  Runs facets and fetches their results. This should not be used directly but
  through the supervision tree.
  """

  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def run(pid) do
    GenServer.cast(pid, :run)
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:run, [{name, mod}, params: params] = facet) do
    score = mod.score(params)
    {:noreply, [{:score, score}|facet]}
  end
end

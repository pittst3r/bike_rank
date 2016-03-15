defmodule BikeRank.Runner do
  use GenServer

  def start_link(facet_name) do
    GenServer.start_link(__MODULE__, facet_name)
  end

  def run(pid, args) do
    GenServer.cast(pid, {:run, args})
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def init(facet_name) do
    {:ok, {facet_name}}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:run, args}, {:speed}) do
    score = BikeRank.Facet.SpeedLimit.score(args)
    {:noreply, {:speed, args, {:score, score}}}
  end
end

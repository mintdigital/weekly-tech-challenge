defmodule GithubProfiler.Query do
  use GenStage

  # Client
  def start_link(%{socket: socket}) do
    GenStage.start_link(__MODULE__, %{socket: socket})
  end

  def update(pid, query), do: GenStage.cast(pid, {:new_query, query})

  # Server
  def init(state), do: {:producer, Map.merge(state, %{pending_demand: 0, query: ""})}

  def handle_cast({:new_query, query}, state) do
    IO.inspect {"update", query}
    {:noreply, [%{state | query: query}], %{state | query: query}}
  end

  def handle_demand(incoming_demand, %{pending_demand: pending_demand}=state) do
    IO.inspect {incoming_demand, state}
    dispatch(%{state|pending_demand: incoming_demand + pending_demand}, [])
  end

  def dispatch(%{query: ""}=state, events) do
    IO.puts "blank"
    IO.inspect events
    {:noreply, events, state}
  end
  def dispatch(%{pending_demand: 0}=state, events) do
    IO.puts "0 demand"
    {:noreply, events, state}
  end
  def dispatch(%{pending_demand: pending_demand}=state, events) do
    dispatch(%{state|pending_demand: pending_demand-1, query: ""}, [state|events])
  end
end

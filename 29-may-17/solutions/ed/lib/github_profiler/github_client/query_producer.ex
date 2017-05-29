defmodule GithubProfiler.QueryProducer do
  use GenStage

  # Client
  def start_link(%{socket: socket, query: query}) do
    GenStage.start_link(__MODULE__, %{socket: socket, query: query})
  end

  def update_query(pid, query), do: GenStage.cast(pid, {:new_query, query})

  # Server
  def init(state), do: {:producer, state}

  def handle_cast({:new_query, query}, state) do
    {:noreply, [], %{state | query: query}}
  end

  def handle_demand(demand, state) when demand > 0 do
    {:noreply, [state], %{state|query: ""}}
  end
end

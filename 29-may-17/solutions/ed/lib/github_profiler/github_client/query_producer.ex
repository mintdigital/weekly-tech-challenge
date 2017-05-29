defmodule GithubProfiler.QueryProducer do
  use GenStage

  # Client
  def start_link(query), do: GenStage.start_link(__MODULE__, query)

  def update_query(pid, query), do: GenStage.cast(pid, {:new_query, query})

  # Server
  def init(query), do: {:producer, query}

  def handle_cast({:new_query, query}, _state), do: {:noreply, [], query}

  def handle_demand(demand, query) when demand > 0, do: {:noreply, [query], nil}
end

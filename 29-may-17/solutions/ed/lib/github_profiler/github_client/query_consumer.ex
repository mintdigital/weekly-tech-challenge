defmodule GithubProfiler.QueryConsumer do
  use GenStage

  # Client
  def start_link(), do: GenStage.start_link(__MODULE__, :ok)

  # Server
  def init(:ok), do: {:consumer, :the_state_does_not_matter}

  def handle_events([%{query: ""}], _from, state), do: {:noreply, [], state}
  def handle_events([%{socket: socket, query: query}]=events, _from, state) do
    # Inspect the events.
    IO.inspect(events)

    results = GithubProfiler.Search.run(query).body
    push_results(socket, results)

    # We are a consumer, so we would never emit items.
    {:noreply, [], state}
  end

  defp push_results(socket, results) do
    Phoenix.Channel.push socket, "results", %{"results" => results}
  end
end

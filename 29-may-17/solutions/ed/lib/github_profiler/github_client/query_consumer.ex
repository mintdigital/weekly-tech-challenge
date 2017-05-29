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

    push_results(socket, query)

    # We are a consumer, so we would never emit items.
    {:noreply, [], state}
  end

  defp push_results(socket, query) do
    Phoenix.Channel.push socket, "results", %{"results" => query}
  end
end

defmodule GithubProfiler.QueryRunner do
  use GenStage
  import Phoenix.Channel, only: [push: 3]

  # Client
  def start_link(), do: GenStage.start_link(__MODULE__, :ok)

  # Server
  def init(:ok), do: {:consumer, :ok}

  def handle_events([%{query: ""}], _from, state), do: {:noreply, [], state}
  def handle_events([%{socket: socket, query: query}], _from, state) do
    GithubProfiler.Search.run(query).body
    |> push_results(socket)

    # We are a consumer, so we would never emit items.
    {:noreply, [], state}
  end

  defp push_results(results, socket) do
    push socket, "results", %{"results" => results}
  end
end

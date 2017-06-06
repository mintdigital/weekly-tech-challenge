defmodule GithubProfiler.QueryRunner do
  use GenStage
  import Phoenix.Channel, only: [push: 3]

  # Client
  def start_link(:ok), do: GenStage.start_link(__MODULE__, :ok)

  # Server
  def init(:ok), do: {:consumer, :ok}

  def handle_events([{_socket, ""}], _from, state), do: {:noreply, [], state}
  def handle_events([{socket, query}], _from, state) do
    GithubProfiler.Search.run(query).body
    |> push_results(socket)

    # We are a consumer, so we would never emit items.
    {:noreply, [], state}
  end

  defp push_results(results, socket) do
    push socket, "results", %{"results" => results}
  end
end

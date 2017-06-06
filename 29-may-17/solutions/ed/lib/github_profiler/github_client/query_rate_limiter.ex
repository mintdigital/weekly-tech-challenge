defmodule GithubProfiler.QueryRateLimiter do
  use GenStage

  # Client
  def start_link(:ok), do: GenStage.start_link(__MODULE__, :ok)

  # Server
  def init(:ok), do: {:producer_consumer, %{}}

  def handle_subscribe(:producer, opts, from, producers) do
    pending = opts[:max_demand] || 1
    interval = opts[:interval] || 1000

    producers =
      producers
      |> Map.put(from, {pending, interval})
      |> ask_and_schedule(from)

    {:manual, producers}
  end
  def handle_subscribe(:consumer, _opts, _from, consumers) do
    {:automatic, consumers}
  end

  def handle_cancel(_, from, producers), do: Map.delete(producers, from)

  def handle_events(events, _from, state), do: {:noreply, events, state}

  def handle_info({:ask, from}, producers) do
    {:noreply, [], ask_and_schedule(producers, from)}
  end

  defp ask_and_schedule(producers, from) do
    case producers do
      %{^from => {pending, interval}} ->
        GenStage.ask(from, pending)
        Process.send_after(self(), {:ask, from}, interval)
        producers
      %{} ->
        producers
    end
  end
end

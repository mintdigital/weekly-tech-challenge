defmodule GithubProfiler.QueryRateLimiter do
  use GenStage

  # Client
  def start_link(), do: GenStage.start_link(__MODULE__, :ok)

  # Server
  def init(_), do: {:producer_consumer, %{}}

  def handle_subscribe(:producer, opts, from, producers) do
    IO.puts "prod sub"
    pending = opts[:max_demand] || 1
    interval = opts[:interval] || 1000

    producers = Map.put(producers, from, {pending, interval})
    producers = ask_and_schedule(producers, from)

    {:manual, producers}
  end
  def handle_subscribe(:consumer, _opts, _from, consumers) do
    IO.puts "con sub"
    {:automatic, consumers}
  end

  def handle_cancel(_, from, producers) do
    {:noreply, [], Map.delete(producers, from)}
  end

  def handle_events(events, from, producers) do
    IO.puts "events rl"
    producers = Map.update!(producers, from, fn {pending, interval} ->
      {pending + length(events), interval}
    end)
    IO.inspect(producers)

    {:noreply, events, producers}
  end

  def handle_info({:ask, from}, producers) do
    {:noreply, [], ask_and_schedule(producers, from)}
  end

  defp ask_and_schedule(producers, from) do
    IO.puts "asking"
    case producers do
      %{^from => {pending, interval}} ->
        IO.inspect(producers)
        GenStage.ask(from, pending)
        Process.send_after(self(), {:ask, from}, interval)
        Map.put(producers, from, {0, interval})
      %{} ->
        producers
    end
  end
end

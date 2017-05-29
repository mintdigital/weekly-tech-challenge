defmodule GithubProfiler.QueryConsumer do
  use GenStage

  def start_link(), do: GenStage.start_link(__MODULE__, :ok)

  def init(:ok), do: {:consumer, :the_state_does_not_matter}

  def handle_events(events, _from, state) do
    # Inspect the events.
    IO.inspect(events)

    # We are a consumer, so we would never emit items.
    {:noreply, [], state}
  end
end

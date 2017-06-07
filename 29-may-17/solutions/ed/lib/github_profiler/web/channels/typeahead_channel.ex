defmodule GithubProfiler.Web.TypeaheadChannel do
  use GithubProfiler.Web, :channel

  def join("typeahead:public", _payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    {:ok, producer_pid} = setup_genstage(socket)
    {:noreply, assign(socket, :producer_pid, producer_pid)}
  end

  def handle_in("search", %{"query" => query}, socket) do
    GithubProfiler.Query.update(socket.assigns.producer_pid, query)

    {:noreply, socket}
  end

  defp setup_genstage(socket) do
    {:ok, producer} = GithubProfiler.Query.start_link(socket)
    {:ok, producer_consumer} = GithubProfiler.QueryRateLimiter.start_link(:ok)
    {:ok, consumer} = GithubProfiler.QueryRunner.start_link(:ok)
    GenStage.sync_subscribe(producer_consumer, to: producer)
    GenStage.sync_subscribe(consumer, to: producer_consumer)
    {:ok, producer}
  end
end

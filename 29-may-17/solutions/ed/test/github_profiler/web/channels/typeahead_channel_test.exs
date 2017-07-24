defmodule GithubProfiler.Web.TypeaheadChannelTest do
  use GithubProfiler.Web.ChannelCase

  alias GithubProfiler.Web.TypeaheadChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(TypeaheadChannel, "typeahead:public")

    {:ok, socket: socket}
  end

  test "search replies with status ok", %{socket: socket} do
    ref = push socket, "search", %{"query" => "username"}
    assert_reply ref, :ok, %{"query" => "username"}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to typeahead:public", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end

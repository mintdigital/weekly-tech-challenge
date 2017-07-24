defmodule GithubProfiler.Web.PageController do
  use GithubProfiler.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

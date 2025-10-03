defmodule BankingWeb.PageController do
  use BankingWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end

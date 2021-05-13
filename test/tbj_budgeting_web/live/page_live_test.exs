defmodule TbjBudgetingWeb.PageLiveTest do
  use TbjBudgetingWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Result"
  end
end

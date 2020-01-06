defmodule Servy.BearController do
  @pages_path Path.expand("pages", File.cwd!())

  alias Servy.Wildthings
  alias Servy.Bear

  import Servy.FileHandler, only: [handle_file: 2]

  defp bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end

  def index(conv) do
    items =
      Wildthings.list_bears()
      |> Enum.filter(&Bear.is_grissly/1)
      |> Enum.sort(&Bear.order_asc_by_name/2)
      |> Enum.map(&bear_item/1)
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %{conv | status: 200, resp_body: "<h1> Bear #{bear.id}: #{bear.name}</h1>"}
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{
      conv
      | status: 201,
        resp_body: "Created a #{type} bear named #{name}"
    }
  end

  def delete(conv, _params) do
    %{conv | status: 403, resp_body: "Bears must never be deleted!"}
  end

  def new(conv) do
    @pages_path
    |> Path.join("form.html")
    |> File.read()
    |> handle_file(conv)
  end
end

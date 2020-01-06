defmodule Servy.Plugins do
  def rewrite_path(%{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%{path: "/bears?id=" <> id} = conv) do
    # can use a regex to match more than just bears
    # capture <thing> and <id> before the regex chars they represent
    # iex> regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
    # Regex.named_captures(regex, path)
    %{conv | path: "/bears/#{id}"}
  end

  def rewrite_path(conv), do: conv

  @doc "Logs request properties"
  def log(conv), do: IO.inspect(conv)

  def track(%{status: 404, path: path} = conv) do
    IO.puts("Warning #{path} is on the loose!")
    conv
  end

  def track(conv), do: conv
end

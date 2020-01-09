# Erlang version
# client() ->
#     SomeHostInNet = "localhost", % to make it runnable on one machine
#     {ok, Sock} = gen_tcp:connect(SomeHostInNet, 5678,
#                                  [binary, {packet, 0}]),
#     ok = gen_tcp:send(Sock, "Some Data"),
#     ok = gen_tcp:close(Sock).

# Transcoded to Elixir
defmodule Servy.HttpClient do
  def send_request(request) do
    # Can't use double quote because in Elixir it's a seq of bytes (a binary)
    # So use single quotes which is a list of characters
    some_host_in_net = 'localhost'
    {:ok, socket} = :gen_tcp.connect(some_host_in_net, 4000, [:binary, packet: :raw, active: false])
    :ok = :gen_tcp.send(socket, request)
    {:ok, response} = :gen_tcp.recv(socket, 0)
    :ok = :gen_tcp.close(socket)
    response
  end
end

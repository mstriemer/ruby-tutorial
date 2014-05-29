require 'socket'
require './frank'
# require 'sinatra'

get '/hi' do
    "Hello World!"
end

get '/hi/:name' do |name|
    "Hello #{name}"
end

get '/bye' do
    "Goodbye"
end

server = TCPServer.open(2000)
while true
    client = server.accept
    http_request = client.gets
    client.puts 'HTTP/1.1 200 OK'
    client.puts
    client.puts match(http_request)
    client.close
end

require './frank'
require './app'

HttpServer.new(2000) do |method, path|
  match(method, path)
end

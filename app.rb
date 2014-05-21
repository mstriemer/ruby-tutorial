require './frank'

@names = []

get '/hi' do
  "Hello World!"
end

get '/bye' do
  "Goodbye World!"
end

get '/hi/all' do
  "Hello #{@names.join(', ')}!"
end

get '/hi/:name' do |name|
  "Hello #{name}!"
end

post '/hi/:name' do |name|
  @names << name
  "Hello #{name}!"
end

HttpServer.new(2000) do |method, path|
  match(method, path)
end

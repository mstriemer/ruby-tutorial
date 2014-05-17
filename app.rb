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

match('GET /hi/all HTTP/1.1')
match('POST /hi/Emily HTTP/1.1')
match('POST /hi/Zoe HTTP/1.1')
match('POST /hi/Lily HTTP/1.1')
match('GET /hi/all HTTP/1.1')

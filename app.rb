require './frank'

get '/hi' do
  "Hello World!"
end

get '/bye' do
  "Goodbye World!"
end

get '/hi/:name' do |name|
    "Hello #{name}!"
end

match('GET /hi/Bob HTTP/1.1')

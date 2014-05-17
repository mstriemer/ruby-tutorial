require './frank'

get '/hi' do
  "Hello World!"
end

get '/bye' do
  "Goodbye World!"
end

match('GET /hi HTTP/1.1')

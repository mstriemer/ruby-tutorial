Names = []

get '/hi' do
  "Hello World!"
end

get '/bye' do
  "Goodbye World!"
end

get '/hi/all' do
  "Hello #{Names.join(', ')}!"
end

get '/hi/:name' do |name|
  "Hello #{name}!"
end

post '/hi/:name' do |name|
  Names << name
  "Hello #{name}!"
end

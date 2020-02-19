require 'sinatra'

get '/hello' do
  erb :hello
end

get '/hello/:name' do |name|
  "Hello #{name}"
end

put '/' do
  'Root'
end

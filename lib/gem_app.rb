require 'bundler/setup'
require 'sinatra'
require 'yajl'

get '/' do
  'This is UNIQ Systems corporate gem server helper service. You are not expected to use it via browser.'
end

post '/gems/new' do
  content_type 'application/json'
  
  response = { :result => 0, :message => 'Gem has been successfully uploaded' }
  
  Yajl::Encoder.encode(response)
end
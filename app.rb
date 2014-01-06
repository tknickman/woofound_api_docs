require 'rubygems'
require 'sinatra'

configure do
  enable :sessions
end



get '/' do
  erb :guides
end

get '/examples' do
  erb :examples
end

get '/v1' do
  erb :v1
end

get '/v2' do
  erb :v2
end

get '/console' do
  erb :console
end

post '/console'do
  post = params[:post]
  erb post['app_secret']
end


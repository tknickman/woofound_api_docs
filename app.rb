require 'rubygems'
require 'sinatra'

configure do
  enable :sessions
end

v1_endpoints = {
    '/' => {
        '/' => {:methods => ["GET"]}},
    '/users' => {
        '/users' => {:methods => ["POST"]},
        '/users/me' => {:methods => ["GET", "PUT"]}},
    '/sliders' => {
        '/sliders' => {:methods => ["GET"]},
        '/sliders/{id}' => {:methods => ["GET"], :variables => ["id"]},
        '/sliders/{id}/results' => {:methods => ["GET"], :variables => ["id"]},
        '/sliders/{id}/entities' => {:methods => ["GET"], :variables => ["id"]},
        '/sliders/{slider_id}/entities/{id}' => {:methods => ["GET"], :variables => ["sliders_id", "id"]},
        '/sliders/{id}/reset' => {:methods => ["DELETE"], :variables => ["id"]},
        '/sliders/{sliders_id}/tags/{id}' => {:methods => ["POST"], :variables => ["sliders_id", "id"]}},
    '/tags' => {
        '/tags/{id}' => {:methods => ["GET"], :variables => ["id"]}}
}


get '/' do
  erb :guides
end

get '/examples' do
  @name = 'new test'
  erb :examples
end

get '/v1' do
  @endpoint_data = v1_endpoints
  erb :v1_new
end

get '/v2' do
  erb :v2
end

get '/console' do
  erb :console
end

post '/examples'do
  post = params[:post]
  @name = post['name']
  puts @name
  erb :examples
end


require 'rubygems'
require 'sinatra'

configure do
  enable :sessions
end

v1_endpoints = {
    '/' => {:methods => ["Get"]},
    '/users' => {:methods => ["Post"]},
    '/users/me' => {:methods => ["Get", "Put"]},
    '/sliders' => {:methods => ["Get"]},
    '/sliders/{id}' => {:methods => ["Get"], :variables => ["id"]},
    '/sliders/{id}/results' => {:methods => ["Get"], :variables => ["id"]},
    '/sliders/{id}/entities' => {:methods => ["Get"], :variables => ["id"]},
    '/sliders/{slider_id}/entities/{id}' => {:methods => ["Get"], :variables => ["sliders_id", "id"]},
    '/sliders/{id}/reset' => {:methods => ["Delete"], :variables => ["id"]},
    '/sliders/{sliders_id}/tags/{id}' => {:methods => ["Post"], :variables => ["sliders_id", "id"]},
    '/tags/{id}' => {:methods => ["Get"], :variables => ["id"]}

}

get '/' do
  erb :guides
end

get '/examples' do
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

post '/console'do
  post = params[:post]
  erb post['app_secret']
end


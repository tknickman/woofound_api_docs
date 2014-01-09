require 'rubygems'
require 'sinatra'
<<<<<<< HEAD
require 'rest_client'
require 'json'

=======
>>>>>>> 8ae1fcf297be4f18c27817dd1208f0082f04220c

configure do
  enable :sessions
end

<<<<<<< HEAD

=======
>>>>>>> 8ae1fcf297be4f18c27817dd1208f0082f04220c
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
<<<<<<< HEAD
        '/sliders/{slider_id}/entities/{id}' => {:methods => ["GET"], :variables => ["slider_id", "id"]},
        '/sliders/{id}/reset' => {:methods => ["DELETE"], :variables => ["id"]},
        '/sliders/{sliders_id}/tags/{id}' => {:methods => ["POST"], :variables => ["slider_id", "id"]}},
=======
        '/sliders/{slider_id}/entities/{id}' => {:methods => ["GET"], :variables => ["sliders-id", "id"]},
        '/sliders/{id}/reset' => {:methods => ["DELETE"], :variables => ["id"]},
        '/sliders/{sliders_id}/tags/{id}' => {:methods => ["POST"], :variables => ["sliders-id", "id"]}},
>>>>>>> 8ae1fcf297be4f18c27817dd1208f0082f04220c
    '/tags' => {
        '/tags/{id}' => {:methods => ["GET"], :variables => ["id"]}}
}


get '/' do
  erb :guides
end

get '/examples' do
  erb :examples
end

post '/examples' do
  post = params[:post]
  @name = post['name']

  puts "HERE "

  erb :guides
end

get '/v1' do
  @endpoint_data = v1_endpoints
  erb :v1_new
end

get '/v2' do
  erb :v2
end

get '/console' do
  @endpoint_data = v1_endpoints
  erb :console
end

post '/console' do
<<<<<<< HEAD

  @endpoint_data = v1_endpoints
  response = call_api(params[:post])


  @result = TRUE
  @code = response.code
  @headers = JSON.pretty_generate(JSON.parse(response.headers.to_json))
  @body = JSON.pretty_generate(JSON.parse(response.body))
=======
  post = params[:post]
  @name = post['name']
>>>>>>> 8ae1fcf297be4f18c27817dd1208f0082f04220c

  erb :console
end


<<<<<<< HEAD
def call_api(post_data)

  unless post_data == nil
    v1_url = "https://core.woofound.com"
    route = post_data['route']
    args_regex = /{\w+}/
    result = post_data['route'].scan(args_regex)
    result.each { |variable|
      route = route.sub(variable, post_data[variable])
    }
    final_url = v1_url + route

    #Built the the authorization header in a new resource

    begin
      resource = RestClient::Resource.new(final_url, post_data['user'], post_data['password'])
      response = resource.get(:content_type => :json, :accept => :json, 'Woofound-App-Secret' => post_data['app_secret'])
    rescue => error
      response = error.response
    end
  end

end


=======
>>>>>>> 8ae1fcf297be4f18c27817dd1208f0082f04220c


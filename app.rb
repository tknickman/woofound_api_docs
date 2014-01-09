require 'rubygems'
require 'sinatra'
require 'rest_client'
require 'json'


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
        '/sliders/{slider_id}/entities/{id}' => {:methods => ["GET"], :variables => ["slider_id", "id"]},
        '/sliders/{id}/reset' => {:methods => ["DELETE"], :variables => ["id"]},
        '/sliders/{sliders_id}/tags/{id}' => {:methods => ["POST"], :variables => ["slider_id", "id"]}},
    '/tags' => {
        '/tags/{id}' => {:methods => ["GET"], :variables => ["id"]}}
}


get '/' do
  erb :guides
end

get '/examples' do
  erb :examples
end

get '/v1' do
  #send in the endpoints data structure so the content can be generated
  @endpoint_data = v1_endpoints
  #call the view
  erb :v1_new
end

get '/v2' do
  #call the view
  erb :v2
end

get '/console' do
  #send in the endpoints data structure so the content can be generated
  @endpoint_data = v1_endpoints
  #call the view
  erb :console
end

post '/console' do
  #send in the endpoints data structure so the content can be generated
  @endpoint_data = v1_endpoints
  #get the post response
  response = call_api(params[:post])

  #set result to true to trigger our results block in console.erb
  @result = TRUE
  #send in the the data from the request to the view
  @code = response.code
  @headers = JSON.pretty_generate(JSON.parse(response.headers.to_json))
  @body = JSON.pretty_generate(JSON.parse(response.body))

  #call the view
  erb :console
end


def call_api(post_data)

  #make sure we actually have post data to work with
  unless post_data == nil

    #build the correct url to hit
    v1_url = "https://core.woofound.com"
    #get the endpoint chosen by the user
    route = post_data['route']
    #get out the variable parts with a regex
    args_regex = /{\w+}/
    result = post_data['route'].scan(args_regex)

    #use each regex match as the hash key to get out the users submitted variable value
    result.each { |variable|
      route = route.sub(variable, post_data[variable])
    }

    #build the final url
    final_url = v1_url + route

    begin
      #Build the the authorization header in a new resource
      resource = RestClient::Resource.new(final_url, post_data['username'], post_data['password'])
      #submit the response and return it
      response = resource.get(:content_type => :json, :accept => :json, 'Woofound-App-Secret' => post_data['app_secret'])
    rescue => error
      #catch and errors, and return those too (how rest_client works)
      response = error.response
    end
  end
end




require 'rubygems'
require 'sinatra'
require 'rest_client'
require 'json'


configure do
  enable :sessions
end


#data structure to generate all documentation and interactive console
#structure = {'route group' => {'specific route' => {:methods => ["GET", "POST", etc...], :variables => ["route_variable_1, route_variable_2, etc..."]}}}
v1_endpoints = {
    '/' => {
        '/' => {:methods => ["GET"]}},
    '/users' => {
        '/users' => {:methods => [{"POST" => {
      :data => {
        'username' => 'username of new user (required)',
        'email' => 'email address of new user (required)',
        'password' => 'password of new user (required)',
        'password_confirmation' => 'password of new user (required)',
        'first_name' => 'fist name of new user (required)',
        'last_name' => 'last name of new user (required)',
        'birthday' => 'birth date of new user (required)'}}}]},
        '/users/me' => {:methods => ["GET", {"PUT" => {
      :data => {
        'username' => 'username of new user (required)',
        'email' => 'email address of new user (required)',
        'password' => 'password of new user (required)',
        'password_confirmation' => 'password of new user (required)',
        'first_name' => 'fist name of new user (required)',
        'last_name' => 'last name of new user (required)',
        'birthday' => 'birth date of new user (required)'}}}]}},
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
  @version_num = '1'
  #call the view
  erb :api_doc_template
end

get '/v2' do
  #TODO: wrong data structure, need to make the one for v2 as well
  #send in the endpoints data structure so the content can be generated
  @endpoint_data = v1_endpoints
  @version_num = '2'
  #call the view
  erb :api_doc_template
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
  #send the response object back to the view so we can autofill the fields
  @autofill = params[:post]
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




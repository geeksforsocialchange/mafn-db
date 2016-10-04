# Basics
require 'sinatra'
require 'json'

# Database
require 'sinatra/activerecord'
require 'pg'

# Models
# require '/models/event'

class AgeAPI < Sinatra::Base

  register Sinatra::ActiveRecordExtension

  get '/' do
    erb :index
  end

  # GET /events
  get '/events' do
    content_type :json
    { name: "Test Event", description: "Event description"}.to_json
  end

  # GET /events/{id}
  get '/events/:id' do
  end

end

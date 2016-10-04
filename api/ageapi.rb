# Basics
require 'sinatra'
require 'json'

# Database
require 'sinatra/activerecord'
require 'pg'
set :database_file, "database.yml"

# Models
require_relative 'models/event'

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

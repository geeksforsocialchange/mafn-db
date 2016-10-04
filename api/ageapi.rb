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

  # GET /events/{start}
  get '/events?start&end&page&category' do
  end

  # GET /events/{id}
  get '/events/:id' do
  end

end

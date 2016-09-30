require 'sinatra'

class AgeAPI < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end

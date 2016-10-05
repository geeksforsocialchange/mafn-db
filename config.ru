# This file is used by Rack-based servers to start the application.

require './api/ageapi.rb'
require ::File.expand_path('../config/environment', __FILE__)

map "/api" do
  run AgeAPI
end

map '/' do
  run Rails.application
end

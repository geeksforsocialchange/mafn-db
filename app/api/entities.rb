require 'grape'

module Entities
  class Event < Grape::Entity
    # desc 'Gets a list of upcoming events'
    # params do
    #   optional :id, type: Integer, default: false
    #   optional :start, type: DateTime, default: Time.now
    #   optional :region, type: Integer, default: 0
    # end
    expose :id
    expose :name
    expose :description
    expose :start
    expose :finish
    expose :created_at
    expose :updated_at
    expose :google_id
    expose :location
    expose :latitude
    expose :longitude
    expose :region
  end
end

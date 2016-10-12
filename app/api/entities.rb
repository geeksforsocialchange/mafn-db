require 'grape'

module Entities
  class Event < Grape::Entity
    # desc 'Gets a list of upcoming events'
    # params do
    #   optional :id, type: Integer, default: false
    #   optional :start, type: DateTime, default: Time.now
    #   optional :region, type: Integer, default: 0
    # end
    expose :id, documentation: { type: "Integer", desc: "Unique key for this API" }
    expose :name
    expose :description
    expose :start, documentation: { type: "DateTime", desc: "Start time" }
    expose :finish, documentation: { type: "DateTime", desc: "Finish time" }
    expose :created_at
    expose :updated_at
    expose :google_id, documentation: { type: "String", desc: "Google Calendar ID this is scraped from" }
    expose :location
    expose :latitude
    expose :longitude
    expose :region, documentation: { type: "Integer", desc: "Region code" }
  end
end

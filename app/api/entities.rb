require 'grape'

module Entities
  class Event < Grape::Entity
    expose :id, documentation: { type: "Integer", desc: "Unique key for this API" }
    expose :name
    expose :description
    expose :start, documentation: { type: "DateTime", desc: "Earliest start time (defaults to now)", default: Time.now }
    expose :finish, documentation: { type: "DateTime", desc: "Latest finish time" }
    expose :region, documentation: { type: "Integer", desc: "Region code. 0 - Hulme & Moss Side. 1 - Burnage. 2 - Moston. 3 - Miles Platting." }
    expose :created_at
    expose :updated_at
    expose :google_id, documentation: { type: "String", desc: "Google Calendar ID this is scraped from" }
    expose :location
    expose :latitude
    expose :longitude
  end
end

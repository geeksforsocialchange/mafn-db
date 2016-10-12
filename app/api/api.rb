require 'grape-swagger'

class API < Grape::API
  # Grape initalisation
  version 'v1', using: :header, vendor: 'ageapi'
  format :json
  prefix :api

  RESPONSE_LIMIT = 50

  # Rescue all errors and return as JSON instead
  rescue_from :all

  resource :events do

    params do
      optional :id,         type: Integer,  desc: "Unique key for this API"
      optional :start,      type: DateTime, desc: "Earliest start time (defaults to now)", default: Time.now
      optional :finish,     type: DateTime, desc: "Latest finish time"
      optional :page,       type: Integer,  desc: "Results page offset"
      optional :region,     type: Integer,  desc: "Region code. 0 - Hulme & Moss Side. 1 - Burnage. 2 - Moston. 3 - Miles Platting."
      optional :google_id,  type: String,   desc: "Google Calendar ID this is scraped from"
    end

    desc "List of next #{RESPONSE_LIMIT} upcoming events."
    get do
      # Initial query, showing only events starting from now
      @events = Event.order(:start)
      # Filter out events before a given start time (default now)
      if params[:start]
        start_time = params[:start].to_date rescue false
      end
      @events.where!("finish > ?", start_time) if start_time
      # Filter out events that start after a given finish time
      if params[:finish]
        finish_time = params[:finish].to_date rescue false
        @events.where!("finish < ?", finish_time) if finish_time
      end
      # Filter by region code
      @events.where!(region: params[:region]) if params[:region]
      # Filter by Google ID
      @events.where!(google_id: params[:google_id]) if params[:google_id]
      # Limit to a sensible number and offset, if requested
      @events.limit!(RESPONSE_LIMIT)
      @events.offset!(params[:page] * RESPONSE_LIMIT) if params[:page]
      # Return the fields defined in our entity
      present @events, with: Entities::Event
    end

    desc "Details for a single event"
    get ':id' do
      @event = Event.find(params[:id])
      present @event, with: Entities::Event
    end
  end

  # Create documentation
  add_swagger_documentation(
      base_path: "/",
      hide_documentation_path: true
    )
end

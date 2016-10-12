require 'grape-swagger'

class API < Grape::API
  # Grape initalisation
  version 'v1', using: :header, vendor: 'placecal'
  format :json
  prefix :api

  # Rescue all errors and return as JSON instead
  rescue_from :all

  resource :events do
    desc "List of upcoming events" do
      params Entities::Event.documentation
    end
    get do
      @events = Event.limit(20)
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

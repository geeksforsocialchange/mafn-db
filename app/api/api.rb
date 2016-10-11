class API < Grape::API
  # Grape initalisation
  version 'v1', using: :header, vendor: 'placecal'
  format :json
  prefix :api

  # Rescue all errors and return as JSON instead
  rescue_from :all

  # Just returning events for now
  mount Placecal::Events
end

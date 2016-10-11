class API < Grape::API
  version 'v1', using: :header, vendor: 'placecal'
  format :json
  prefix :api

  mount Placecal::Events
end

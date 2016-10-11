class API < Grape::API
  version 'v1', using: :header, vendor: 'mafn'
  format :json
  prefix :api

  mount Placecal::Events
end

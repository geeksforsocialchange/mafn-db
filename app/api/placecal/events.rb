module Placecal
  class Events < Grape::API
    desc 'Gets a list of upcoming events'
    resource :events do
      get do
        Event.limit(20)
      end
    end
  end
end

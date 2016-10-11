module Placecal
  class Events < Grape::API
    desc 'Gets a list of upcoming events'
    params do
      optional :id, type: Integer
    end
    resource :events do
      get do
        if params[:id]
          Event.find(params[:id])
        else
          Event .order(:start)
                .where("finish > ?", Time.now)
                .limit(50)
                .select(:id, :name, :start, :finish, :description, :created_at, :updated_at, :google_id, :location, :latitude, :longitude, :region)
        end
      end
    end
  end
end

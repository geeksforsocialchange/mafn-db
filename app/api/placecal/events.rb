module Placecal
  class Events < Grape::API
    desc 'Gets a list of upcoming events'
    params do
      optional :id, type: Integer, default: false
      optional :start, type: DateTime, default: Time.now
      optional :region, type: Integer, default: 0
    end
    resource :events do
      get do
        if params[:id]
          Event .select(:id, :name, :start, :finish, :description, :created_at, :updated_at, :google_id, :location, :latitude, :longitude, :region)
                .find(params[:id])
        else
          Event .order(:start)
                .select(:id, :name, :start, :finish, :description, :created_at, :updated_at, :google_id, :location, :latitude, :longitude, :region)
                .where("finish > ?", params[:start])
                .limit(50)
        end
      end
    end
  end
end

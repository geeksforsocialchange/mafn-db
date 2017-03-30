namespace :events do
  task geolocate: :environment do
    Event.geolocate_all
  end
end

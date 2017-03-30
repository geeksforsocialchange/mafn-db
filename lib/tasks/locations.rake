namespace :locations do
  task geolocate: :environment do
    Location.geolocate_all
  end
end

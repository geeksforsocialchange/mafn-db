class GeolocateJob < ActiveJob::Base
  queue_as :low_priority

  POSTCODE_REGEX = /^\s*((GIR\s*0AA)|((([A-PR-UWYZ][0-9]{1,2})|(([A-PR-UWYZ][A-HK-Y][0-9]{1,2})|(([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))))\s*[0-9][ABD-HJLNP-UW-Z]{2}))\s*$/i

  def perform(address_string, object_to_update)
    # Skip if we're testing
    puts "Starting geocode for #{address_string}".colorize(:blue)
    return false if ENV['RAILS_ENV'] == "test"
    # Get the postcode from the location string
    postcode = address_string.split(",").map { |s| s.delete(' ') }.find { |e| e.match(POSTCODE_REGEX) }
    # Return false if we didn't find a postcode
    return false unless postcode
    # Get a lat/lng from postcodes.io
    response = RestClient.get "http://api.postcodes.io/postcodes/#{postcode}"
    result = JSON.parse(response)
    return false unless (result['result']['latitude'] && result['result']['longitude'])
    object_to_update.update_column(:latitude, result['result']['latitude'])
    object_to_update.update_column(:longitude, result['result']['longitude'])
    puts "Geocoded #{address_string} to #{result['result']['latitude']}, #{result['result']['longitude']}".colorize(:green)
  end
end

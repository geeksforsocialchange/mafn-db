class GeolocateJob < ActiveJob::Base
  queue_as :low_priority

  POSTCODE_REGEX = /((GIR\s*0AA)|((([A-PR-UWYZ][0-9]{1,2})|(([A-PR-UWYZ][A-HK-Y][0-9]{1,2})|(([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))))\s*[0-9][ABD-HJLNP-UW-Z]{2}))/i

  def perform(address_string, object_to_update)
    # Skip if we're testing
    return false if ENV['RAILS_ENV'] == "test"
    puts "Starting geocode for #{address_string}".colorize(:blue)
    # Get the postcode from the location string
    postcode = GeolocateJob.extract_postcode(address_string)
    # Return false if we didn't find a postcode
    return false unless postcode
    # Get a lat/lng from postcodes.io
    begin
      response = RestClient.get "http://api.postcodes.io/postcodes/#{postcode}"
    rescue
      return false
    end
    result = JSON.parse(response)
    return false unless (result['result']['latitude'] && result['result']['longitude'])
    object_to_update.update_column(:latitude, result['result']['latitude'])
    object_to_update.update_column(:longitude, result['result']['longitude'])
    puts "Geocoded #{address_string} to #{result['result']['latitude']}, #{result['result']['longitude']}".colorize(:green)
  end

  # Check that this is a legitimate postcode
  def self.extract_postcode(address_string)
    a = address_string.match(POSTCODE_REGEX)
    return a[0].delete(' ') if a
  end

end

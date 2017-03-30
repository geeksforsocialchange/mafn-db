module HasGeocoding
  extend ActiveSupport::Concern

  POSTCODE_REGEX = /^\s*((GIR\s*0AA)|((([A-PR-UWYZ][0-9]{1,2})|(([A-PR-UWYZ][A-HK-Y][0-9]{1,2})|(([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))))\s*[0-9][ABD-HJLNP-UW-Z]{2}))\s*$/i

  included do

    def geolocate
      unless ENV['RAILS_ENV'] = "test"
        # Get the postcode from the location string
        postcode = self.location.match(POSTCODE_REGEX)[0].delete("\s")
        return false unless postcode
        # Get a lat/lng from postcodes.io
        response = RestClient.get "http://api.postcodes.io/postcodes/#{postcode}"
        result = JSON.parse(response)
        puts result
        return false unless result['result']['latitude']
        update_column(:latitude, result['result']['latitude'])
        update_column(:longitude, result['result']['longitude'])
      end
    end

  end

end

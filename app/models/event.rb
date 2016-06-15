class Event < ActiveRecord::Base
  has_many :attendances
  has_many :members, through: :attendances
  validates_presence_of :name, :start, :finish, :location
  validates_uniqueness_of :google_id, :allow_blank => true, :allow_nil => true
  enum category: [ :research, :project, :partnership ]
  accepts_nested_attributes_for :attendances, allow_destroy: true

  after_save :geolocate, if: :location_changed?

  POSTCODE_REGEX = /(GIR 0AA)|((([A-Z-[QVX]][0-9][0-9]?)|(([A-Z-[QVX]][A-Z-[IJZ]][0-9][0-9]?)|(([A-Z-[QVX]][0-9][A-HJKPSTUW])|([A-Z-[QVX]][A-Z-[IJZ]][0-9][ABEHMNPRVWXY])))) [0-9][A-Z-[CIKMOV]]{2})/

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

  def pretty_start
    self.start.strftime("%d %b %Y, %H:%M")
  end

  def pretty_finish
    self.finish.strftime("%H:%M")
  end

  def duration
    time = ((self.finish - self.start) / 60 ).to_i
    time.to_s + "mins"
  end

  def ydm
    d = self.start
    "#{d.year.to_s.rjust(2, '0')}-#{d.month.to_s.rjust(2, '0')}-#{d.day.to_s.rjust(2, '0')}"
  end

  def attendees
    self.members.count
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |event|
        csv << event.attributes.values_at(*column_names)
      end
    end
  end
end

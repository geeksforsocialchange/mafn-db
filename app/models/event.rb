class Event < ActiveRecord::Base
  belongs_to :entity

  has_many :attendances
  has_many :members, through: :attendances
  has_one :arranger
  has_one :project, through: :arranger

  validates_presence_of :name, :start, :finish, :location
  validates_uniqueness_of :google_id, :allow_blank => true, :allow_nil => true

  accepts_nested_attributes_for :attendances, allow_destroy: true

  after_save :geolocate, if: :location_changed?

  after_create do
    self.update(entity_id: Entity.create.id)
  end

  enum category: [ :research, :project, :partnership ]

  enum event_type: {
    "Meeting": 0,
    "Seminar": 1,
    "Forum": 2,
    "Launch Event": 3,
    "Other": 4
  }

  POSTCODE_REGEX = /^\s*((GIR\s*0AA)|((([A-PR-UWYZ][0-9]{1,2})|(([A-PR-UWYZ][A-HK-Y][0-9]{1,2})|(([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))))\s*[0-9][ABD-HJLNP-UW-Z]{2}))\s*$/i

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

  # IDs of people who did a questionnaire for this
  def responders
    QuestionResponse.where(entity_id: self.entity_id).pluck(:member_id).uniq
  end

  def has_finished?
    self.finish ? self.finish < Time.now : false
  end

  def select_string
    "#{self.id}. #{self.name}"
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

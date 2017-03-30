class Event < ActiveRecord::Base
  include HasRegion

  # Can be referenced by questions
  belongs_to :entity
  # Is imported by a calendar
  belongs_to :calendar

  # Events have attendees (members) and arrangers (projects)
  has_many :attendances
  has_many :members, through: :attendances
  has_one :arranger
  has_one :project, through: :arranger

  # Essential fields
  validates_presence_of :name, :start, :finish, :location

  # Uniquely identify the event using it's Google ID
  validates_uniqueness_of :google_id, :allow_blank => true, :allow_nil => true

  accepts_nested_attributes_for :attendances, allow_destroy: true

  # After saving, parse the location for a postcode and geolocate it
  after_save :geolocate, if: :location_changed?

  # After creating, give it an entity ID
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

  scope :like, -> (filter) { where("  name ilike '%#{filter}%' OR location ilike '%#{filter}%'") }

  def self.geolocate_all
    events = Event.where(latitude: nil)
    events.each { |e| e.geolocate }
  end

  def geolocate
    GeolocateJob.perform_later(location, self)
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

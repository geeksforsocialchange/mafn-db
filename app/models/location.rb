class Location < ActiveRecord::Base
  belongs_to :entity

  validates_presence_of :name

  scope :like, -> (filter) { where("  name ilike '%#{filter}%'
                                      OR line1 ilike '%#{filter}%'
                                      OR line2 ilike '%#{filter}%'
                                      OR city ilike '%#{filter}%'
                                      OR postcode ilike '%#{filter}%'")}

  after_create do
    self.update(entity_id: Entity.create.id)
  end

  after_save :geolocate, if: :postcode_changed?

  #=== Class Methods ===#
  def self.geolocate_all
    locations = Location.where(latitude: nil).where.not(postcode: nil)
    locations.each { |e| e.geolocate }
  end

  #=== Instance Methods ===#
  def full_address
    "#{name}, #{line1}, #{line2}, #{city}, #{postcode}"
  end

  def geolocate
    GeolocateJob.perform_later(postcode, self)
  end

end

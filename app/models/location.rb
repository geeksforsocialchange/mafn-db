class Location < ActiveRecord::Base
  validates_presence_of :name

  after_create do
    self.update(entity_id: Entity.create.id)
  end

  def full_address
    "#{name}, #{line1}, #{line2}, #{city}, #{postcode}"
  end
end

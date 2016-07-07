class Location < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :entity

  after_create do
    self.update(entity_id: Entity.create.id)
  end

  def full_address
    "#{name}, #{line1}, #{line2}, #{city}, #{postcode}"
  end
end

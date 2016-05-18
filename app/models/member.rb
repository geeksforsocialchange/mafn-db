class Member < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :dob
  belongs_to :entity

  after_create do
    self.update(entity_id: Entity.create.id)
  end

  # TODO: Create relationships
  # has_many :question_responses
  # has_many :locations, :through => :member_locations
  # has_many :event_attendances
  # has_and_belongs_to_many :projects


  # Returns their age in years
  def age
    Time.now.year - self.dob.year
  end
end

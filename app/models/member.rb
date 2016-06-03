class Member < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :dob, :region
  has_many :locations, through: :member_locations
  has_many :question_responses
  belongs_to :entity

  accepts_nested_attributes_for :question_responses, allow_destroy: true

  enum region: {
    "Hulme & Moss Side": 0,
    "Burnage": 1,
    "Moston": 2,
  }

  after_create do
    self.update(entity_id: Entity.create.id)
  end

  # TODO: Create relationships
  # has_many :event_attendances
  # has_and_belongs_to_many :projects

  # Returns their age in years
  def age
    Time.now.year - self.dob.year
  end

  def full_name
    self.last_name + ", " + self.first_name
  end

  def initials
    self.first_name.first + self.last_name.first
  end

  def region_code
    return case self.region
    when "Hulme & Moss Side"
      'HM'
    when "Burnage"
      'BU'
    when "Moston"
      'MO'
    end
  end

  def date_sorted_responses
    self.question_responses.order(:created_at).reverse
  end

  def membership_code
    "AFN-#{self.region_code}-#{self.id.to_s.rjust(4, '0')}-#{self.initials}"
  end
end

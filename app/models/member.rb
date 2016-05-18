class Member < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :dob

  # has_many :question_responses
  # has_many :locations, :through => :member_locations
  # has_many :event_attendances
  # belongs_to :entity
  # TODO: Create projects
  # has_and_belongs_to_many :projects
end

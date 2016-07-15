class Volunteer < ActiveRecord::Base
  belongs_to :member
  belongs_to :project

  validates_presence_of :member, :project
end

class Attendance < ActiveRecord::Base
  belongs_to :member
  belongs_to :event
  validates_presence_of :member, :event
  validates_uniqueness_of :member, :scope => :event
end

class MemberLocation < ActiveRecord::Base
  belongs_to :member
  belongs_to :location
  validates_presence_of :member, :location

  accepts_nested_attributes_for :location, :reject_if => :all_blank
end

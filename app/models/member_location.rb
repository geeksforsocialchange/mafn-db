class MemberLocation < ActiveRecord::Base
  belongs_to :member
  belongs_to :location
  validates_presence_of :member, :location, :from
end

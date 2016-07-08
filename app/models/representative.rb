class Representative < ActiveRecord::Base
  belongs_to :member
  belongs_to :organisation

  validates_presence_of :member, :organisation
end

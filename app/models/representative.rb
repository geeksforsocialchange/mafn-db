class Representative < ActiveRecord::Base
  belongs_to :member
  belongs_to :organisation
end

class Partner < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :project
end

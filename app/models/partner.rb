class Partner < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :project

  validates_presence_of :organisation, :project
end

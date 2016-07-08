class Arranger < ActiveRecord::Base
  belongs_to :project
  belongs_to :event

  validates_presence_of :project, :event
end

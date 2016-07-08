class Arranger < ActiveRecord::Base
  belongs_to :project
  belongs_to :event
end

class Calendar < ActiveRecord::Base
  include HasRegion
  
  belongs_to :project
end

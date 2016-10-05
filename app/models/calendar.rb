class Calendar < ActiveRecord::Base
  include HasRegion

  belongs_to :project

  validates_presence_of :url, :project

end

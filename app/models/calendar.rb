class Calendar < ActiveRecord::Base
  include HasRegion

  belongs_to :project

  validates_presence_of :url, :project

  def import_events
  end

  def validate_url
  end
  
end

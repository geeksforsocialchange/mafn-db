class Event < ActiveRecord::Base
  validates_presence_of :name
  enum type: [ :research, :project, :neighbourhood ]
end

class Entity < ActiveRecord::Base
  def parent
    if member = Member.where(entity_id: self.id).first
      return member
    elsif location = Location.where(entity_id: self.id).first
      return location
    elsif event = Event.where(entity_id: self.id).first
      return event
    elsif project = Project.where(entity_id: self.id).first
      return project
    else
      return false
    end
  end
end

class QuestionResponse < ActiveRecord::Base
  belongs_to :question
  belongs_to :responder, :class_name => :Member, :foreign_key => "member_id"
  belongs_to :subject, :class_name => :Entity, :foreign_key => "entity_id"

  validates_presence_of :responder, :question, :subject, :response

end

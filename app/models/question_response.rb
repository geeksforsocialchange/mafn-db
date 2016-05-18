class QuestionResponse < ActiveRecord::Base
  belongs_to :member
  belongs_to :question
  belongs_to :entity

  validates_presence_of :member_id, :question_id, :response
end

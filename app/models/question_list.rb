class QuestionList < ActiveRecord::Base
  belongs_to :question
  belongs_to :question_set

  validates_presence_of :question,  :question_set
end

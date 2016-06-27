class QuestionSet < ActiveRecord::Base
  has_many :question_lists
  has_many :questions, through: :question_lists
  accepts_nested_attributes_for :questions

  validates_presence_of :title
end

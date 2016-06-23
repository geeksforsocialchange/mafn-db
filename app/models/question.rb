class Question < ActiveRecord::Base
  has_many :question_lists
  has_many :question_sets, through: :question_lists
  has_many :question_responses
  accepts_nested_attributes_for :question_responses, allow_destroy: true
  validates_presence_of :question, :category

  enum category: {
    member: 0,
    event: 1,
    location: 2,
  }

end

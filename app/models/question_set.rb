class QuestionSet < ActiveRecord::Base
  has_and_belongs_to_many :questions
  accepts_nested_attributes_for :questions

  validates_presence_of :title
end

class Question < ActiveRecord::Base
  has_and_belongs_to_many :question_sets

  validates_presence_of :question, :response
end

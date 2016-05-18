class QuestionSet < ActiveRecord::Base
  has_and_belongs_to_many :questions

  validates_presence_of :title
end

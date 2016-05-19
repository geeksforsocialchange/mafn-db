class Question < ActiveRecord::Base
  has_and_belongs_to_many :question_sets
  validates_presence_of :question, :category

  enum category: {
    member: 0,
    event: 1,
    location: 2,
  }

end

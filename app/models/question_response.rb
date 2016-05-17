class QuestionResponse < ActiveRecord::Base
  belongs_to :entity
  belongs_to :member
end

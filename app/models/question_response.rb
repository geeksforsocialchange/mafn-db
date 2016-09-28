class QuestionResponse < ActiveRecord::Base
  belongs_to :question
  belongs_to :responder, :class_name => :Member, :foreign_key => "member_id"
  belongs_to :subject, :class_name => :Entity, :foreign_key => "entity_id"

  validates_presence_of :responder, :question, :response

  scope :like, -> (filter) { where("response ilike '%#{filter}%'") }

  def formatted_response
    response_options = self.question.response
    if response_options && response_options.length > 0
      # If there's something here, it's a JSON array of possible responses
      response_options = JSON.parse(response_options)
      # So return the correct text string instead of the raw number
      response_options[self.response.to_i]
    else
      # Or, just return if it there's no validation criteria
      self.response
    end
  end

end

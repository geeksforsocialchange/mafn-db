module ApplicationHelper

  def last_response(member, question, entity = false)
    # Find the question the response relates to
    q = Question.where(question: question).pluck(:id)
    # If it exists...
    if !q.empty?
      # Then check the responses to the question
      if entity
        # If this is questions about a specific thing then check that
        r = QuestionResponse.where(question: q, responder: member, subject: entity)
      else
        # If not then just the previous response
        r = QuestionResponse.where(question: q, responder: member)
      end
      # If there are responses, return the last one
      if !r.empty?
        return r.last.formatted_response
      end
    else
      "ERROR: Question not found!"
    end
  end

  def last_response_if_in_array(member, question, options)
    q = Question.where(question: question).pluck(:id)
    if !q.empty?
      r = QuestionResponse.where(question: q, responder:member)
      if !r.empty?
        response = r.last.formatted_response
        return response if options.include? response
      end
    else
      "ERROR: Question not found!"
    end
  end

end

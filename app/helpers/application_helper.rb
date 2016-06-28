module ApplicationHelper

  def last_response(member, question)
    q = Question.where(question: question).pluck(:id)
    if !q.empty?
      r = QuestionResponse.where(question: q, responder:member)
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

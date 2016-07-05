module ApplicationHelper

  def get_response(member, question, **opts)
    # Find the question the response relates to
    q = Question.where(question: question).pluck(:id)
    # If it exists...
    if !q.empty?
      # Then check the responses to the question
      if opts[:entity]
        # If this is questions about a specific thing then check that
        r = QuestionResponse.where(question: q, responder: member, subject: opts[:entity])
      else
        # If not then just the previous response
        r = QuestionResponse.where(question: q, responder: member)
      end
      # If there are responses, return the last one
      if !r.empty?
        # If first == true, then get the first answer instead
        if opts[:initial] == true
          return r.first.formatted_response
        else
          return r.last.formatted_response
        end
      end
    else
      "ERROR: Question not found!"
    end
  end

end

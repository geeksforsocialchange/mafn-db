module ApplicationHelper

  def get_response(member, question, **opts)
    # Does this refer to an entity?
    entity      = opts[:entity]
    # Are we only getting followup responses?
    followup    = opts[:followup]
    # Are we only getting responses in a given date range?
    date_range  = opts[:date_range]
    # Find the question the response relates to
    q = Question.where(question: question).pluck(:id)
    # If it exists...
    if !q.empty?
      # Then check the responses to the question
      if entity
        # We don't care about the member if it's a project (for now)
        if member
          # If this is questions about a specific thing then check that
          r = QuestionResponse.where(question: q, responder: member, subject: entity)
        else
          r = QuestionResponse.where(question: q, subject: entity)
        end
      else
        # If not then just the previous response
        r = QuestionResponse.where(question: q, responder: member)
      end
      # If there are responses, return the last one
      if !r.empty?
        if !followup
          # If first == true, then get the first answer
          return r.first.formatted_response
        else
          # If it's not, then get by date passed in from the parameter
          # Presuming there is only one result on any given day here.
          if !date_range.nil?
            response = r.where(created_at: date_range)
            if response.length > 0
              return response.first.formatted_response
            else
              return ""
            end
          else
            return "ERROR: Date mismatch!"
          end
        end
      end
    else
      "ERROR: Question not found!"
    end
  end

  def ymd date
    if date.class == Date || date.class == Time
      date.strftime("%Y-%m-%d")
    else
      ""
    end
  end

end

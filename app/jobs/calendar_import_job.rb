require 'open-uri'

class CalendarImportJob < ActiveJob::Base
  queue_as :default

  def perform(url)
    uri = URI.parse(url)
    c = nil
    uri.open { |f| c = Icalendar.parse(f).first }
    c.events.each do |e|
      # Check if it's already in there
      existing_event = Event.where(google_id: "#{e.uid}").first
      if existing_event
        Rails.logger.info "Updating event #{e.summary} (#{e.uid})".colorize(:green)
        # If it is, just update it
        existing_event.update(
                      name: e.summary,
                      start: e.dtstart,
                      finish: e.dtend,
                      description: e.description,
                      location: e.location.html_safe
                    )
      else
        # Otherwise add it to the DB
        event = Event.new( name: e.summary,
                      start: e.dtstart,
                      finish: e.dtend,
                      description: e.description,
                      location: e.location.html_safe,
                      category: :partnership,
                      google_id: e.uid
                    )
        if event.valid?
          Rails.logger.info "Adding event #{e.summary} (#{e.uid})".colorize(:green)
          event.save!
        else
          Rails.logger.warn "INVALID: Event #{e.summary} (#{e.uid})".colorize(:red)
        end
      end
    end
  end
end

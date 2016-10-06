require 'open-uri'

class CalendarImportJob < ActiveJob::Base
  queue_as :default

  def perform(calendar)
    Rails.logger.info "Importing #{calendar.project.name}".colorize(:blue)
    # Parse the URL into a Ruby URI object
    uri = URI.parse(calendar.url)
    # Quit unless this starts with http
    return unless ["http", "https"].include? uri.scheme
    ical = false
    ical = uri.open { |f| Icalendar.parse(f).first }
    # If we have something valid
    if ical
      # Then run through any event object
      ical.events.each do |e|
        # Check if it's already in there
        existing_event = Event.where(google_id: "#{e.uid}").first
        if existing_event
          Rails.logger.info "Updating event #{e.summary} (#{e.uid})".colorize(:blue)
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
                        google_id: e.uid,
                        region: calendar.region,
                        is_funded: calendar.is_funded_default
                      )
          if event.valid?
            Rails.logger.info "Adding event #{e.summary} (#{e.uid})".colorize(:green)
            event.save!
          else
            Rails.logger.warn "INVALID: Event #{e.summary} (#{e.uid})".colorize(:red)
          end
        end
      end
    else
      Rails.logger.warn "INVALID: Not an ICS feed, or ICS feed contains no events".colorize(:red)
    end
  end
end

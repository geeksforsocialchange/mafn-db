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
      # VAriables to track what happens
      created_events = 0
      updated_events = 0
      events_with_errors = 0
      error_log = ""
      # Then run through any event object
      ical.events.each do |e|
        # Check if it's already in there
        existing_event = Event.where(google_id: "#{e.uid}").first
        if existing_event
          Rails.logger.info "Updating event #{e.summary} (#{e.uid})".colorize(:blue)
          existing_event_copy = existing_event
          # If it is, just update it
          existing_event.update(
                        name: e.summary,
                        start: e.dtstart,
                        finish: e.dtend,
                        description: e.description,
                        location: e.location.html_safe
                      )
          if existing_event != existing_event_copy
            updated_events += 1
          end
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
            created_events += 1
            event.save!
          else
            error_message = "INVALID: Event #{e.summary} (#{e.uid})"
            Rails.logger.warn error_message.colorize(:red)
            events_with_errors += 1
            error_log = error_log + "\n" + error_message
          end
        end
        # Update the time stamp and save
        log = "#{Time.now} \n\n"
        log += "#{created_events} added \n#{updated_events} updated \n#{events_with_errors} errors \n"
        if events_with_errors
          log += error_log
          calendar.has_errors = true
        else
          calendar.has_errors = false
        end
        calendar.log = log
        calendar.last_imported = Time.now
        calendar.save!
      end
    else
      Rails.logger.warn "INVALID: Not an ICS feed, or ICS feed contains no events".colorize(:red)
    end
  end
end

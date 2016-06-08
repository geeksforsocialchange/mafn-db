namespace :calendar do
  desc "TODO"
  task import: :environment do
    # Open the file
    f = File.open("./calendars/mafn.ics")
    # Parse it with the ical gem
    c = Icalendar.parse(f).first
    c.events.each do |e|
      # Check if it's already in there
      existing_event = Event.where(google_id: "#{e.uid}").first
      if existing_event
        puts "Updating event #{e.summary} (#{e.uid})".colorize(:green)
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
          puts "Adding event #{e.summary} (#{e.uid})".colorize(:green)
          event.save!
        else
          puts "INVALID: Event #{e.summary} (#{e.uid})".colorize(:red)
        end
      end
    end
  end

  task download: :environment do
    `wget -O ./calendars/mafn.ics https://calendar.google.com/calendar/ical/d0ok3oc2trd21adadm3b8qaimg%40group.calendar.google.com/public/basic.ics`
  end

  task destroy: :environment do
    Event.destroy_all
  end
end

namespace :calendar do
  desc "TODO"
  task import: :environment do
    f = File.open("./calendars/mafn.ics")
    c = Icalendar.parse(f).first
    c.events.each do |e|
      Event.create(name: e.summary, date: e.dtstart, description: e.description)
    end
  end

  task download: :environment do
    `wget -O ./calendars/mafn.ics https://calendar.google.com/calendar/ical/d0ok3oc2trd21adadm3b8qaimg%40group.calendar.google.com/public/basic.ics`
  end

  task destroy: :environment do
    Event.destroy_all
  end
end

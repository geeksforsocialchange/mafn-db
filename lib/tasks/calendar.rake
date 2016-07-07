namespace :calendar do
  task import: :environment do
    CalendarImportJob.perform_later
  end

  task destroy: :environment do
    Event.destroy_all
  end
end

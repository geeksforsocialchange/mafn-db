require 'test_helper'

class CalendarImportJobTest < ActiveJob::TestCase

  setup do
    @valid_url = "https://calendar.google.com/calendar/ical/d0ok3oc2trd21adadm3b8qaimg%40group.calendar.google.com/public/basic.ics"
    @invalid_url = "fdsfdsfdsFSDfdsfsd"
  end

  test "job runs correctly" do
    CalendarImportJob.perform_now(@valid_url)
    CalendarImportJob.perform_now(@invalid_url)
  end

end

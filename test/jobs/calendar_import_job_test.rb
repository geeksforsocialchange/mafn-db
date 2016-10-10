require 'test_helper'

class CalendarImportJobTest < ActiveJob::TestCase

  setup do
    @calendar = create(:calendar)
    @calendar_with_bad_url = create(:calendar_with_bad_url)
  end

  test "job runs correctly" do
    CalendarImportJob.perform_now(@calendar)
    CalendarImportJob.perform_now(@calendar_with_bad_url)
  end

end

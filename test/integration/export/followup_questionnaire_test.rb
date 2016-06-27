require 'test_helper'

class ExportFollowupQuestionnaireTest < ActionDispatch::IntegrationTest

  setup do
    @events = create(:event)
  end

  test "event spreadsheet export" do
    sheet = load_spreadsheet "followup_questionnaire"

    # We're just testing the first row
    head = sheet.row(1)
    content = sheet.row(2)


  end
end

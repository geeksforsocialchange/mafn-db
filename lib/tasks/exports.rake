namespace :exports do

  EXPORTS = ["events", "events_feedback", "events_demographics", "members", "questionnaire"]
  EXPORTS_LOCATION = "/tmp/exports/"

  task test: :environment do
    require 'roo'
    errors = 0
    EXPORTS.each do |e|
      s = load_spreadsheet e
      header = s.row(1)
      s.each_with_index do |row, row_idx|
        error_cells = []
        row.each_with_index do |cell, cell_idx|
          if cell.to_s.include?("ERROR")
            errors += 1
            puts "#{header[cell_idx]}. Row #{row_idx}, Col #{cell_idx}: #{cell}"
          end
        end
      end
    end
    puts errors ? "#{errors} errors found!".colorize(:red) : "No errors found.".colorize(:green)
  end

  task get_all: :environment do
    require 'open-uri'
    EXPORTS.each do |e|
      puts "Getting #{e}..."
      get_export e
    end
  end

  def get_export(export, params = "")
    download = open("http://localhost:3000/exports/#{export}.xlsx")
    IO.copy_stream(download, "#{Rails.root}#{EXPORTS_LOCATION}#{export}.xlsx")
  end

  def load_spreadsheet(spreadsheet)
    wb = Roo::Excelx.new("#{Rails.root}#{EXPORTS_LOCATION}#{spreadsheet}.xlsx")
    wb.sheet(0)
  end

end

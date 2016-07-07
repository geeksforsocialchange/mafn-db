namespace :exports do

  EXPORTS = ["events", "events_feedback", "events_demographics", "members", "questionnaire"]
  EXPORTS_LOCATION = "/tmp/exports/"

  task test: :environment do
    require 'roo'
    download_all
    errors = 0
    EXPORTS.each do |e|
      s = load_spreadsheet e
      header = s.row(1)
      row_errors = false
      # Check each row
      s.each_with_index do |row, row_idx|
        next if row_errors
        row.each_with_index do |cell, cell_idx|
          if cell.to_s.include?("ERROR")
            errors += 1
            puts "#{s.sheets.first}: #{cell_idx}. #{header[cell_idx]}. Row #{row_idx}: #{cell}"
            row_errors = true
          end
        end
      end
    end
    puts errors ? "#{errors} errors found!".colorize(:red) : "No errors found.".colorize(:green)
  end

  task get_all: :environment do
    download_all
  end

  def download_all
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

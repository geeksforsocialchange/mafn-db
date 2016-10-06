class AddStatusToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :last_imported, :datetime
    add_column :calendars, :log, :text
    add_column :calendars, :has_errors, :boolean, default: false
  end
end

class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.references :project, index: true
      t.integer :is_funded_default
      t.string :url
      t.integer :region_default

      t.timestamps null: false
    end
    add_foreign_key :calendars, :projects
  end
end

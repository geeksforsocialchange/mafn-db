class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.date :start
      t.date :finish
      t.integer :type
      t.references :organisation, index: true
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :partners, :organisations
    add_foreign_key :partners, :projects
  end
end

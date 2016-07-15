class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.date :start
      t.date :finish
      t.references :primary_partner_organisation, references: :organisations, index: true
      t.references :resident_champion, references: :members, index: true
      t.references :resident_seconder, references: :members, index: true

      t.timestamps null: false
    end
    add_foreign_key :projects, :organisations, column: :primary_partner_organisation_id
    add_foreign_key :projects, :members, column: :resident_champion_id
    add_foreign_key :projects, :members, column: :resident_seconder_id
  end
end

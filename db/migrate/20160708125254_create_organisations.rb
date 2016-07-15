class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name
      t.references :location, index: true

      t.timestamps null: false
    end
    add_foreign_key :organisations, :locations
  end
end

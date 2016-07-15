class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives do |t|
      t.string :job_title
      t.date :start
      t.date :finish
      t.references :member, index: true
      t.references :organisation, index: true

      t.timestamps null: false
    end
    add_foreign_key :representatives, :members
    add_foreign_key :representatives, :organisations
  end
end

class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.boolean :public
      t.string :street
      t.string :address1
      t.string :address2
      t.string :postcode
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end

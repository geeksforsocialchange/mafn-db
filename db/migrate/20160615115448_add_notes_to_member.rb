class AddNotesToMember < ActiveRecord::Migration
  def change
    add_column :members, :notes, :string
  end
end

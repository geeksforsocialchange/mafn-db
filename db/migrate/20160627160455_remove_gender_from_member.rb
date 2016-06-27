class RemoveGenderFromMember < ActiveRecord::Migration
  def change
    remove_column :members, :gender, :string
  end
end

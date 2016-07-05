class AddEthnicBackgroundToMember < ActiveRecord::Migration
  def change
    add_column :members, :ethnic_background, :integer
    add_column :members, :ethnic_background_other, :string
  end
end

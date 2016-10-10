class AddFundedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_funded, :boolean, default: false
  end
end

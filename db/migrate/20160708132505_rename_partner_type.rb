class RenamePartnerType < ActiveRecord::Migration
  def change
    rename_column :partners, :type, :partner_type
  end
end

class Address < ActiveRecord::Base
  validates :name, :presence => true, if: :public?
end

class Organisation < ActiveRecord::Base
  belongs_to :location

  has_many :representatives
  has_many :members, through: :representatives
  has_many :partners
  has_many :projects, through: :partners
end

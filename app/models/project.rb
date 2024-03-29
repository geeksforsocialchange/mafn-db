class Project < ActiveRecord::Base
  include HasRegion

  belongs_to :primary_partner_organisation, class_name: :Organisation
  belongs_to :resident_champion, class_name: :Member
  belongs_to :resident_seconder, class_name: :Member
  belongs_to :entity

  has_many :arrangers
  has_many :events, through: :arrangers
  has_many :partners
  has_many :organisations, through: :partners
  has_many :volunteers
  has_many :members, through: :volunteers

  validates_presence_of :region, :name

  after_create do
    self.update(entity_id: Entity.create.id)
  end

  def select_string
    "#{self.id}. #{self.name}"
  end

end

class Member < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :dob, :region
  has_many :member_locations
  has_many :locations, through: :member_locations
  has_many :question_responses
  has_many :attendances
  has_many :events, through: :attendances
  belongs_to :entity

  accepts_nested_attributes_for :question_responses, allow_destroy: true
  accepts_nested_attributes_for :member_locations, allow_destroy: true
  accepts_nested_attributes_for :locations

  enum region: {
    "Hulme & Moss Side": 0,
    "Burnage": 1,
    "Moston": 2,
    "Miles Platting": 3,
  }

  enum ethnic_background: {
    # Asian options
    "Bangladeshi": 0, "Chinese": 1, "Indian": 2, "Pakistani": 3, "Any other Asian/ Asian British Background (please state)": 4,
    # Black options
    "African": 5, "Caribbean": 6, "Any other Black / Black British Background (please state)": 7,
    # White options
    "English/Northern Irish/Scottish/Welsh": 8, "Irish": 9, "Gypsy/Traveller/Irish Traveller": 10, "Any other white background (please state)": 11,
    "Any other background": 12, "Any mixed background": 13
  }

  def export_ethnicity
    # Should output array for easy insertion into export spreadsheets
    r = []
    e = self[:ethnic_background]
    t = self.ethnic_background
    o = self.ethnic_background_other || ""
    # Options 0 - 4 if present
    e.between?(0, 4) ? r << t : r << ""
    # Other background if 4
    e == 4 ? r << o : r << ""
    # Options 5 - 7 if present
    e.between?(5, 7) ? r << t: r << ""
    # Other background if 7
    e == 7 ? r << o : r << ""
    # Options 8 - 11 if present
    e.between?(8, 11) ? r << t : r << ""
    # Other background if 11
    e == 11 ? r << o : r << ""
    # Other background or "any other background" if 12
    e == 12 ? r << o || "Any other background" : r << ""
    # Other background or "any mixed background" if 13
    e == 13 ? r << o || "Any mixed background" : r << ""
    r
  end

  after_create do
    self.update(entity_id: Entity.create.id)
  end

  # TODO: Create relationships
  # has_many :event_attendances
  # has_and_belongs_to_many :projects

  # Returns their age in years
  def age
    Time.now.year - self.dob.year
  end

  def full_name
    self.last_name + ", " + self.first_name
  end

  # Need to give entity lookups a consistent interface
  alias name full_name

  def initials
    self.first_name.first + self.last_name.first
  end

  def region_code
    return case self.region
    when "Hulme & Moss Side"
      'HM'
    when "Burnage"
      'BU'
    when "Moston"
      'MO'
    end
  end

  def date_sorted_responses
    self.question_responses.order(:question_id, :created_at).reverse
  end

  def grouped_responses
    r = self.question_responses
    r.group_by(&:question_id)
  end

  def membership_code
    "AFN-#{self.region_code}-#{self.id.to_s.rjust(4, '0')}-#{self.initials}"
  end
end

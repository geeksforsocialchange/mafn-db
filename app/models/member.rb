class Member < ActiveRecord::Base
  include HasRegion

  belongs_to :entity

  has_many :member_locations, dependent: :destroy
  has_many :locations, through: :member_locations
  has_many :question_responses, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances
  has_many :volunteers, dependent: :destroy
  has_many :projects, through: :volunteers
  has_many :representatives, dependent: :destroy
  has_many :organisations, through: :representatives

  has_many :resident_champions, class_name: :Project, foreign_key: :resident_champion_id, dependent: :nullify
  has_many :resident_seconders, class_name: :Project, foreign_key: :resident_seconder_id, dependent: :nullify

  validates_presence_of :first_name, :last_name, :dob, :region

  accepts_nested_attributes_for :question_responses, allow_destroy: true
  accepts_nested_attributes_for :member_locations, allow_destroy: true
  accepts_nested_attributes_for :locations

  # Allows our index controller to search on these fields
  scope :like, -> (filter) { where("  email ilike '%#{filter}%'
                                      OR first_name ilike '%#{filter}%'
                                      OR last_name ilike '%#{filter}%'
                                      OR tel ilike '%#{filter}%'
                                      OR mob ilike '%#{filter}%'")}

  scope :filter_region, -> (filter_region) { where(:region => filter_region) }

  enum ethnic_background: {
    # Asian options
    "Bangladeshi": 0, "Chinese": 1, "Indian": 2, "Pakistani": 3, "Any other Asian/ Asian British Background (please state)": 4,
    # Black options
    "African": 5, "Caribbean": 6, "Any other Black / Black British Background (please state)": 7,
    # White options
    "English/Northern Irish/Scottish/Welsh": 8, "Irish": 9, "Gypsy/Traveller/Irish Traveller": 10, "Any other white background (please state)": 11,
    "Any other background": 12, "Any mixed background": 13
  }

  after_create do
    self.update(entity_id: Entity.create.id)
  end

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

  def export_ethnicity
    return ["", "", "", "", "", "", ""] unless self.ethnic_background
    # Output an array for easy insertion into export spreadsheets
    r = []
    # ID
    e = self[:ethnic_background]
    # Text
    t = self.ethnic_background
    # Other option
    o = self.ethnic_background_other || ""
    # Options 0 - 4 if present
    e.between?(0, 4) ? r << t : r << ""
    # Other background if 4
    e == 4 ? r << o : r << ""
    # Options 5 - 7 if present
    e.between?(5, 7) ? r << t : r << ""
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
    return r
  end

  # Sort responses by date for the member view
  def date_sorted_responses
    self.question_responses.order(:question_id, :created_at).reverse
  end

  # Responses grouped by ID
  def grouped_responses
    r = self.question_responses
    r.group_by(&:question_id)
  end

  # Questions grouped by day for doing followups
  def response_days
    # Get all the unique days that the member responded to a question on
    days = self.question_responses.order("date_trunc('day', created_at)").pluck("date_trunc('day', created_at)").uniq
    # Return these as an array of ranges
    days.map! { |d| d.beginning_of_day..d.end_of_day }
  end

  # Code for membership card
  def membership_code
    "AFN-#{self.region_code}-#{self.id.to_s.rjust(4, '0')}-#{self.initials}"
  end
end

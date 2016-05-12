Member
  has_many :question_responses
  has_many :locations, :through => :member_locations
  has_many :event_attendances
  has_many :question_responses
  has_many :questions, :as => :questionable
MemberLocation
  belongs_to :member
  belongs_to :location, :as => :locatable
Question
  has_and_belongs_to_many :question_sets
  belongs_to :questionable, :polymorphic => true
QuestionSet
  has_and_belongs_to_many :questions
QuestionResponse
  has_one :member
  has_one :question
Location
  belongs_to :locateable, :polymorphic => true
  has_many :questions, :as => :questionable
Event
  has_one :location, :as => :locateable
  has_many :event_attendances
  has_many :questions, :as => :questionable
EventAttendance
  has_one :event
  has_one :member


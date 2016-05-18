Member
  has_many :question_responses
  has_many :locations, :through => :member_locations
  has_many :event_attendances
  belongs_to :entity
  has_and_belongs_to_many :projects
MemberLocation
  # Members can move and we want to store the change
  belongs_to :member
  belongs_to :location
Question
  # Subject of the question
  has_and_belongs_to_many :question_sets
QuestionSet
  has_and_belongs_to_many :questions
QuestionResponse
  belongs_to :member
  belongs_to :question
  belongs_to :entity
Location
  belongs_to :entity
Event
  has_one :location
  has_many :event_attendances
  belongs_to :entity
  belongs_to :project
EventAttendance
  belongs_to :event
  belongs_to :member
Project
  has_and_belongs_to_many :members
  has_many :events
Entity
  # Index that just stores a member, location, or event
  # Effectively "has_one :member, :location, or :event"

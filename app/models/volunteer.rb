class Volunteer < ActiveRecord::Base
  belongs_to :member
  belongs_to :project

  validates_presence_of :member, :project

  # Add TODO: add role properties
  # Befriending or mentoring
  # Campaigning
  # Co-researcher
  # Designing an activity or event
  # Educating/teaching/coaching
  # Equalities Board Member
  # Leading the group
  # Make decisions on funding
  # Organising people to run an event
  # Older People's Network Member
  # Other practical help
  # Providing information/ counselling
  # Providing transport/ driving
  # Raising or handling money
  # Secretarial, admin or clerical work
  # Sit on investment panels
  # Visiting people
  # Other (please state)
  # Prefer not to say
end

class Member < ActiveRecord::Base
  validates_presence_of :name
  enum gender: [ :male, :female, :other ]
end

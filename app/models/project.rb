class Project < ActiveRecord::Base
  belongs_to :primary_partner_organisation, class_name: :Organisation
  belongs_to :resident_champion, class_name: :Member
  belongs_to :resident_seconder, class_name: :Member
end

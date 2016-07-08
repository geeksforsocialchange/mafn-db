class Project < ActiveRecord::Base
  belongs_to :primary_partner_organisation
  belongs_to :resident_champion
  belongs_to :resident_seconder
end

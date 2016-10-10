module HasRegion
  extend ActiveSupport::Concern
  included do
    
    enum region: {
      "Hulme & Moss Side": 0,
      "Burnage": 1,
      "Moston": 2,
      "Miles Platting": 3,
    }

    # Short code for our member's ID
    def region_code
      return case self[:region]
      when 0
        'HM'
      when 1
        'BU'
      when 2
        'MO'
      when 3
        'MP'
      end
    end

    def region_email
      return case self[:region]
      when 0
        "hulmemossside@afmcr.org"
      when 1
        "burnage@afmcr.org"
      when 2
        "moston@afmcr.org"
      when 3
        "milesplatting@afmcr.org"
      end
    end

    def region_website
      return case self[:region]
      when 0
        "hulmemossside.afmcr.org"
      when 1
        "burnage.afmcr.org"
      when 2
        "moston.afmcr.org"
      when 3
        "milesplatting.afmcr.org"
      end
    end
  end
end

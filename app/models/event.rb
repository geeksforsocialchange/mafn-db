class Event < ActiveRecord::Base
  validates_presence_of :name
  enum category: [ :research, :project, :neighbourhood ]

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |event|
        csv << event.attributes.values_at(*column_names)
      end
    end
  end
end

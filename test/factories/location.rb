FactoryGirl.define do
  factory :location do
    name "Zion Community Arts Centre"
    entity_id 2
  end

  factory :full_location, class: Location do
    name "Kath Locke Centre"
    line1 "123 Moss Lane East"
    line2 "Hulme"
    city "Manchester"
    postcode "M15 5DD"
    latitude 53.4604329
    longitude -2.2512753
  end
end

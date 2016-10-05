FactoryGirl.define do
  factory :event do
    name "Healthy Relationships"
    description "Event to celebrate the re-opening of Trinity House!\nMore detai
     ls to come!\n\nContact: Lydia on 0161 225 1064 or email info@trinityhousecr
     c.org.uk"
    location "Trinity House Community Resource Centr\, Grove Close\, off Platt L
      ane Rusholme Manchester M14 5AA"
    start Time.parse("Sat, 04 Jun 2016 16:22:13")
    finish Time.parse("Sat, 04 Jun 2016 18:22:13")
    is_funded false
  end
end

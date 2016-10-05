FactoryGirl.define do
  factory :calendar do
    association :project
    is_funded_default false
    url "https://calendar.google.com/calendar/ical/d0ok3oc2trd21adadm3b8qaimg%40group.calendar.google.com/public/basic.ics"
    region 1

    factory :calendar_with_bad_url do
      url "dsadsadasdasdsad"
    end
  end
end

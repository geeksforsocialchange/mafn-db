FactoryGirl.define do
  factory :user do
    email "kim@alliscalm.net"
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
  end
end

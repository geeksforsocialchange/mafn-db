require 'test_helper'

class GeolocateJobTest < ActiveJob::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "postcode sanitiser works correctly" do

    locations = [
      {
        address: "Our Lady's Church, Raby Street, Moss Side, M16 7JQ",
        match: "M167JQ"
      },{
        address: "Armani Centre, Quinney Cresent Shoreham Close, Manchester, M16 7DG",
        match: "M167DG"
      },{
        address: "Nephra Good Neighbours, 27 Parkfield Rd N, Manchester M40 3TB, United Kingdom",
        match: "M403TB"
      },{
        address: "Manchester Tennis & Football Centre Etihad Campus, Gate 2, Alan Turing Way Manchester M11 3FF Follow us @CITCTweets www.facebook.com/mcfccitc",
        match: "M113FF"
      },{
        address: "Zion Community Resource Centre, 339 Stretford Rd, Manchester M15 4ZY, United Kingdom",
        match: "M154ZY"
      },{
        address: "Millennium Powerhouse Library",
        match: nil
      },{
        address: "m15 5RH",
        match:   "m155RH"
      },{
        address: "",
        match: nil
      }
    ]

    locations.each do |location|
      assert_equal location[:match], GeolocateJob.extract_postcode(location[:address]), "#{location[:address]} did not match!"
    end

  end
end

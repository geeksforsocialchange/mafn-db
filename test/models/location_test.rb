require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  setup do
    @location = build(:location)
    @full_location = build(:location)
  end

  test "is valid" do
    assert @location.valid?
    assert @full_location.valid?
  end

  test "gets assigned entity id after being saved" do
    @location.save
    assert @location.entity_id
  end
end

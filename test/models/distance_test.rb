require 'test_helper'

class DistanceTest < ActiveSupport::TestCase

  test "should not save distance without any params" do
    distance = Distance.new
    assert_not distance.save, false
  end

  test "should not save distance with distance <= 0 or > 100000" do
    distance_less = Distance.new(origin: "A", destination: "B", distance: -1)
    assert_not distance_less.save, false
    distance_greater = Distance.new(origin: "A", destination: "B", distance: 100001)
    assert_not distance_greater.save, false
  end

  test "should create distance" do
    distance = Distance.new(origin: "A", destination: "B", distance: 50.5)
    assert distance.save, true
  end

  test "should validates origin and destination" do
    distance = Distance.new(distance: 50)
    assert_not distance.save, false
  end

  test "should update or create a new distance" do
    created = Distance.where(origin: "A", destination: "B", distance: 40).update_or_create(origin: "A", destination: "B", distance: 40)
    (assert created , true)  && (assert Distance.count , 1)
    updated = Distance.where(origin: "A", destination: "B", distance: 40).update_or_create(origin: "A", destination: "F", distance: 74)
    (assert updated, true) && (assert Distance.count, 1)
  end

end

require "test_helper"

class UnitTest < ActiveSupport::TestCase
  test "it creates" do
    assert Unit.create!(unit_number: '1', floor_plan: 'Studio')
  end

  test "resident_status_as_of when vacant" do
    unit = Unit.new(move_in: nil, move_out: nil)
    assert_equal :vacant, unit.resident_status_as_of(Date.today)
  end

  test "resident_status_as_of when future" do
    unit = Unit.new(move_in: Date.tomorrow)
    assert_equal :future, unit.resident_status_as_of(Date.today)
  end

  test "resident_status_as_of when current" do
    unit = Unit.new(move_in: Date.yesterday)
    assert_equal :current, unit.resident_status_as_of(Date.today)
  end

  test "resident_status_as_of when past" do
    unit = Unit.new(move_in: 5.days.ago, move_out: 1.day.ago)
    assert_equal :vacant, unit.resident_status_as_of(Date.today)
  end
end

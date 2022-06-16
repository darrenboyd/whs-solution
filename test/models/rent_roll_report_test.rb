require "test_helper"

class RentRollReportTest < ActiveSupport::TestCase

  setup do
    Unit.create!(unit_number: '1', floor_plan: 'Studio')
    Unit.create!(unit_number: '2', floor_plan: 'Studio',
        resident: 'Alice', move_in: 3.days.ago, move_out: 10.days.from_now)
    Unit.create!(unit_number: '3', floor_plan: 'Suite',
        resident: 'Bob', move_in: 4.days.from_now, move_out: 20.days.from_now)
  end

  test "it generates the rent roll data" do
    rent_roll = RentRollReport.new
    rent_roll.generate
    actual = rent_roll.rent_roll_data

    assert_equal 3, actual.length
    assert_equal ['1', 'Studio', nil, :vacant, nil, nil], actual[0]
    assert_equal ['2', 'Studio', 'Alice', :current, 3.days.ago.to_date, 10.days.from_now.to_date], actual[1]
    assert_equal ['3', 'Suite', 'Bob', :future, 4.days.from_now.to_date, 20.days.from_now.to_date], actual[2]
  end


  test "it generates the key statistics" do
    rent_roll = RentRollReport.new
    rent_roll.generate
    actual = rent_roll.key_statistics

    expected = {
      'Vacant Units' => 1,
      'Occupied Units' => 1,
      'Leased Units' => 2,
    }
    assert_equal expected, actual
  end
end

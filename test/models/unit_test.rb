require "test_helper"

class UnitTest < ActiveSupport::TestCase
  test "it creates" do
    assert Unit.create!(unit_number: '1', floor_plan: 'Studio')
  end
end

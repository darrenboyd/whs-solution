class Unit < ApplicationRecord
  validates :unit_number, :floor_plan, presence: true

  def resident_status_as_of(status_as_of)
    return :vacant if move_in.nil? and move_out.nil?
    return :current if move_in < status_as_of and move_out > status_as_of
    return :future if move_in > status_as_of and move_out > status_as_of
  end
end

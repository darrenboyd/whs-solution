class Unit < ApplicationRecord
  validates :unit_number, :floor_plan, presence: true

  def resident_status_as_of(status_as_of)
    return :vacant if move_in.nil? && move_out.nil?
    return :vacant if move_out && move_out < status_as_of
    return :current if move_in <= status_as_of && (move_out.nil? || move_out > status_as_of)
    return :future if move_in > status_as_of
  end
end

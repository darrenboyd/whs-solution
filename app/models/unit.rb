class Unit < ApplicationRecord
  validates :unit_number, :floor_plan, presence: true
end


class RentRollReport

  attr_reader :as_of_date

  def initialize(as_of: nil)
    @as_of_date = as_of || Date.today
  end

  def generate
    return if @units
    @units = Unit.all.sort_by(&:unit_number)
  end

  def rent_roll_data
    generate
    @units.map do |unit|
      [
        unit.unit_number,
        unit.floor_plan,
        unit.resident,
        unit.resident_status_as_of(as_of_date),
        unit.move_in,
        unit.move_out,
      ]
    end
  end

  def key_statistics
    generate
    stats = {'Vacant Units' => 0, 'Occupied Units' => 0, 'Leased Units' => 0}
    @units.each do |unit|
      case unit.resident_status_as_of(as_of_date)
      when :vacant
        stats['Vacant Units'] += 1
      when :current
        stats['Occupied Units'] += 1
        stats['Leased Units'] += 1
      when :future
        stats['Leased Units'] += 1
      end
    end

    stats
  end

end
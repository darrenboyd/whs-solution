
class RentRollReport

  attr_reader :as_of_date

  def initialize(as_of: nil)
    @as_of_date = case as_of
    when nil
      Date.today
    when String
      Date.parse(as_of)
    else
      as_of&.to_date
    end
  end

  def generate
    return if @units
    @units = Unit.all.sort_by(&:unit_number)
    self
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

  FORMAT = "%8s  %-10s  %-20s  %-7s  %-10s  %-10s"
  def print_report
    puts FORMAT % ['Unit', 'Floor Plan', 'Resident', 'Status', 'Move In', 'Move Out']
    rent_roll_data.each do |row|
      puts FORMAT % row
    end
    nil
  end

  def print_key_statistics
    key_statistics.each do |name, value|
      puts "%15s: %d" % [name, value]
    end
    nil
  end

  def print_full_report
    puts "=== RENT ROLL REPORT for #{@as_of}"
    print_report
    puts "\n===\n"
    print_key_statistics
    nil
  end
end
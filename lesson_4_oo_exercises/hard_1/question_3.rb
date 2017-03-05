module EfficiencyAndRange
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include EfficiencyAndRange

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  include EfficiencyAndRange

  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  include EfficiencyAndRange

  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Seacraft
  include EfficiencyAndRange

  attr_accessor :hull_count, :properller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    self.properller_count = num_propellers
    self.hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

class Catamaran < Seacraft
end

motorboat1 = Motorboat.new(15, 30)
p motorboat1.fuel_efficiency

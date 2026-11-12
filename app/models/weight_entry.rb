class WeightEntry < ApplicationRecord
  belongs_to :user

  validates :recorded_on, presence: true
  validates :weight, presence: true, numericality: { greater_than: 0 }

  scope :chronological, -> { order(recorded_on: :asc) }
  scope :recent, -> { order(recorded_on: :desc) }

  def self.unit_options
    [
      ["Pounds (lb)", "lb"],
      ["Kilograms (kg)", "kg"],
      ["Ounces (oz)", "oz"]
    ]
  end

  def self.convert_to_pounds(value, unit)
    converted = value.to_f
    normalized_unit = unit.to_s.downcase

    case normalized_unit
    when "kg"
      converted * 2.20462
    when "oz"
      converted / 16.0
    else
      converted
    end
  end

  def self.convert_from_pounds(value, unit)
    converted = value.to_f
    normalized_unit = unit.to_s.downcase

    case normalized_unit
    when "kg"
      converted / 2.20462
    when "oz"
      converted * 16.0
    else
      converted
    end
  end

  def display_value(unit)
    WeightEntry.convert_from_pounds(weight, unit)
  end
end

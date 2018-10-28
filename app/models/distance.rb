class Distance < ApplicationRecord
  validates :origin, presence: true
  validates :destination, presence: true
  validates :distance, numericality: {greater_than: 0, less_than_or_equal_to: 100000}

  def self.update_or_create(attributes)
    assign_or_new(attributes).save
  end

  def self.assign_or_new(attributes)
    obj = first || new
    obj.assign_attributes(attributes)
    obj
  end
end

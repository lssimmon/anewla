class Todo < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :priority, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  scope :by_priority, -> { order(priority: :desc, due_date: :asc) }
  scope :by_due_date, -> { order(due_date: :asc, priority: :desc) }
end

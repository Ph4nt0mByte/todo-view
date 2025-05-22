class Todo < ApplicationRecord
  VALID_STATUSES = ['pending', 'in_progress', 'completed']

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, length: { maximum: 1000 }, allow_blank: true
  validates :status, inclusion: { in: VALID_STATUSES }, presence: true
end

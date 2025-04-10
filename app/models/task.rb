class Task < ApplicationRecord
  belongs_to :category
  validates :description, presence: true, length: { minimum: 2, maximum: 30 }
  before_validation :set_default_due_date

  def set_default_due_date
    self.due_date ||= Date.today
  end
end

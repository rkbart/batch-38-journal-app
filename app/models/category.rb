class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }, uniqueness: { scope: :name }
end
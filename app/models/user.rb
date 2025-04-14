class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_many :tasks, through: :categories

  after_create :create_default_category

  private

  def create_default_category
    categories.create(name: "Uncategorized")
  end
end

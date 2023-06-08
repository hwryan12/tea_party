class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  validates_presence_of :title, :price, :status

  enum status: { active: 0, cancelled: 1 }
end
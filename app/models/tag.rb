class Tag < ApplicationRecord
  paginates_per 25
  validates :name, presence: true
  validates :sign, presence: true
  enum kind: {expenses: 1, income: 2 }
  belongs_to :user
end

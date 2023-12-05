class Batch < ApplicationRecord
  has_many :expenses
  has_many :incomes
  has_many :flocks
end

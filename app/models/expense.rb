class Expense < ApplicationRecord
  belongs_to :batch

  def total
    unit_price.to_i * quantity.to_i
  end
end

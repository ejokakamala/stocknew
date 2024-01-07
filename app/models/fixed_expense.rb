class FixedExpense < ApplicationRecord

  def total
    cost.to_i * quantity.to_i
  end
end

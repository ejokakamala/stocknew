class Income < ApplicationRecord
  belongs_to :batch

  
  def amount
    unit_price.to_i * quantity.to_i
  end
end

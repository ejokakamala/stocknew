class Flock < ApplicationRecord
  belongs_to :batch

  def current_stock
    initial_stock - (died_stock + sold_stock)
  end

  def age_in_weeks
    ((Time.now - date_in)/(86400 * 7)).round(2)
  end
end

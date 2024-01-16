require 'csv'

class FixedExpense < ApplicationRecord

  def total
    cost.to_i * quantity.to_i
  end

  def self.to_csv
    attributes = FixedExpense.column_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |fixed_expense|
        csv << attributes.map{ |attr| fixed_expense.send(attr) }
      end
    end
  end
end

require 'csv'

class Income < ApplicationRecord
  belongs_to :batch

  
  def amount
    unit_price.to_i * quantity.to_i
  end

  def self.to_csv
    attributes = Income.column_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |income|
        csv << attributes.map{ |attr| income.send(attr) }
      end
    end
  end
end

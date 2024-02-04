require 'csv'

class Expense < ApplicationRecord
  belongs_to :batch

  paginates_per 10

  def total
    unit_price.to_i * quantity.to_i
  end

  def self.to_csv
    attributes = Expense.column_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |expense|
        csv << attributes.map{ |attr| expense.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Expense.create! row.to_hash
    end
  end
end

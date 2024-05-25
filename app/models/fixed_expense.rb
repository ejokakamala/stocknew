require 'csv'

class FixedExpense < ApplicationRecord

  belongs_to :user

  paginates_per 10

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

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      FixedExpense.create! row.to_hash
    end
  end
end

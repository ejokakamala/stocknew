require 'csv'

class Batch < ApplicationRecord
  has_many :expenses
  has_many :incomes
  has_many :flocks

  def self.to_csv
    attributes = Batch.column_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |batch|
        csv << attributes.map{ |attr| batch.send(attr) }
      end
    end
  end
end

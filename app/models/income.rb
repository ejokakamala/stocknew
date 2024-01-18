require 'csv'

class Income < ApplicationRecord
  paginates_per 10

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


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row| 
      Income.create! row.to_hash
    end
  end
end

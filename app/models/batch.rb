require 'csv'

class Batch < ApplicationRecord
  paginates_per 10

  belongs_to :user

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

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Batch.create! row.to_hash
    end
  end
end

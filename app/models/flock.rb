require 'csv'

class Flock < ApplicationRecord
  paginates_per 10

  belongs_to :batch
  belongs_to :user

  def current_stock
    initial_stock - (died_stock + sold_stock)
  end

  # def age_in_weeks
  #   ((Time.now.to_date - date_in)/7).to_f.round(1)
  # end

  def age_in_weeks
    ((Time.now.to_date - date_in)/7).to_f.round(1)
  end

  def self.to_csv
    attributes = Flock.column_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |flock|
        csv << attributes.map{ |attr| flock.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Flock.create! row.to_hash
    end
  end
end

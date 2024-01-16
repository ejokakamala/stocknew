require 'csv'

class Flock < ApplicationRecord
  belongs_to :batch

  def current_stock
    initial_stock - (died_stock + sold_stock)
  end

  def age_in_weeks
    ((Time.now - date_in)/(86400 * 7)).round(2)
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
end

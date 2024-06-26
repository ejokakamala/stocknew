require 'csv'

class Flock < ApplicationRecord
  paginates_per 10

  validates :date_in, presence: true
  validates :initial_stock, presence: true
  validates :retirement_date, presence: true

  belongs_to :batch
  belongs_to :user

  #used_stock = died_stock + sold_stock
 
  def latest_stock
    initial_stock.to_i - (died_stock.to_i + sold_stock.to_i)
  end

  def age_in_weeks
    t = Time.now.to_date
    a = date_in.to_date
    #((Time.now.to_date - date_in.to_date)/7).to_f.round(1)
    r = ((t - a)/7)
    res = r.to_f.round(1)
    return res
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

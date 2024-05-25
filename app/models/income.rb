require 'csv'

class Income < ApplicationRecord
  paginates_per 10

  belongs_to :batch
  belongs_to :user
  
  def amount
    unit_price.to_i * quantity.to_i
  end

  # def searched_amount 
  #   if params[:date_between]
  #     starts = params[:date_between].split(" - ").first
  #     starts_for_select = Date.strptime(starts, "%m/%d/%Y")
  #     ends = params[:date_between].split(" - ").second
  #     ends_for_select = Date.strptime(ends, "%m/%d/%Y")
  #     @incomes = Income.where(date: starts_for_select..ends_for_select).page(params[:page])
  #     @sum = @incomes.amount
  #   else
  #     @sum = amount.order(:batch_id).page(params[:page])
  #   end
  # end

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

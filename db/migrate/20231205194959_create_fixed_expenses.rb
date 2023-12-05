class CreateFixedExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :fixed_expenses do |t|
      t.date :date_in
      t.string :type_of_expense
      t.integer :cost
      t.integer :quantity
      t.integer :total_cost
      t.text :description

      t.timestamps
    end
  end
end

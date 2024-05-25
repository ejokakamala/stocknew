class AddUserToIncome < ActiveRecord::Migration[7.1]
  def change
    add_reference :incomes, :user, null: false, foreign_key: true
  end
end

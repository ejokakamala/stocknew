class AddUserToExpense < ActiveRecord::Migration[7.1]
  def change
    add_reference :expenses, :user, null: false, default: 2, foreign_key: true
  end
end

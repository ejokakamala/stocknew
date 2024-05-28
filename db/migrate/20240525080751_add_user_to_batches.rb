class AddUserToBatches < ActiveRecord::Migration[7.1]
  def change
    add_reference :batches, :user, null: false, default: 2, foreign_key: true
  end
end

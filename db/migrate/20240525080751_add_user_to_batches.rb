class AddUserToBatches < ActiveRecord::Migration[7.1]
  def change
    add_column :batches, :user_id, :integer
  end
end

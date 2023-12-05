class CreateBatches < ActiveRecord::Migration[7.1]
  def change
    create_table :batches do |t|
      t.integer :batch_no
      t.string :flock_type

      t.timestamps
    end
  end
end

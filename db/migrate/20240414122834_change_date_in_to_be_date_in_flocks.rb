class ChangeDateInToBeDateInFlocks < ActiveRecord::Migration[7.1]
  def change
    change_column :flocks, :date_in, :date
  end
end

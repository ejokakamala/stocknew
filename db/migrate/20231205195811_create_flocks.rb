class CreateFlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :flocks do |t|
      t.integer :batch_no
      t.datetime :date_in
      t.date :retirement_date
      t.string :source
      t.integer :initial_stock
      t.integer :died_stock, default: 0
      t.integer :age
      t.text :notes
      t.string :status
      t.integer :sold_stock, default: 0
      t.references :batch, null: false, foreign_key: true

      t.timestamps
    end
  end
end

json.extract! expense, :id, :date, :category, :quantity, :unit_price, :total_amount, :description, :batch_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)

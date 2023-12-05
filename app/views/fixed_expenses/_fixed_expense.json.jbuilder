json.extract! fixed_expense, :id, :date_in, :type_of_expense, :cost, :quantity, :total_cost, :description, :created_at, :updated_at
json.url fixed_expense_url(fixed_expense, format: :json)

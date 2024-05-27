class PublicController < ApplicationController
  def dashboard
    @incomes = Income.all
    @expenses = Expense.all
    @flocks = Flock.all
    @batches = Batch.all
    @fixed_expenses = FixedExpense.all
  end
end

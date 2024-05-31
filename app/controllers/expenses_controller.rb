class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]

  # GET /expenses or /expenses.json
  def index
    if params[:date_between]
      starts = params[:date_between].split(" - ").first
      starts_for_select = Date.strptime(starts, "%m/%d/%Y")
      ends = params[:date_between].split(" - ").second
      ends_for_select = Date.strptime(ends, "%m/%d/%Y")
      @expenses = current_user.expenses.where(date: starts_for_select..ends_for_select).page(params[:page])
      @total_expenses = @expenses.map(&:total).sum
      @searched_expenses = current_user.expenses.where(date: starts_for_select..ends_for_select)
      @total_searched_expenses = @searched_expenses.map(&:total).sum
    else
      @all_expenses = current_user.expenses.order(:batch_id)  
      @total_all_expenses = @all_expenses.map(&:total).sum
      @expenses = @all_expenses.page(params[:page])
      @total_per_page = @expenses.map(&:total).sum
    end

    @title = "All Expenses"

    @exp = current_user.expenses.ransack(params[:q])
    respond_to do |format|
      format.html
      format.csv { send_data @exp.result.to_csv }
    end
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = current_user.expenses.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @expense = current_user.expenses.build(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy!

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    Expense.import(params[:file], current_user) 
    redirect_to expenses_path, notice: "Expenses imported"
  end

  # def import_data(xlsx_path)
  #   xlsx = Roo::Spreadsheet.open(path[:xlsx_path])
  #   xlsx.sheet(0).each_with_index(date: 'date', category: 'category', 
  #                                 quantity: 'quantity', unit_price: 'unit_price', total_amount: 'total_amount', 
  #                                 description: 'description', batch_id: 'batch_id') do |row, row_index|
                                  
  #       next if row_index == 0 || User.find_by(username: row[:username]).present?

  #       User.create(
  #           firstname: row[:firstname],
  #           lastname: row[:lastname],
  #           username: row[:username],
  #           email: row[:email],
  #           age: row[:age]
  #       )
  #   end
  # end

  # def bulk_add_data
  #   file = params[:xml_file]
  #   xlsx = Roo::Spreadsheet.open(file, extension: :xlsx)
  #   count = xlsx.count
  #   for i in 1...count do
  #     batch_no = xlsx.row(i+1)[0]
  #     date = xlsx.row(i+1)[1]
  #     category = xlsx.row(i+1)[2]
  #     quantity = xlsx.row(i+1)[3]
  #     unit_price = xlsx.row(i+1)[4]
  #     total_amount = xlsx.row(i+1)[5]
  #     description = xlsx.row(i+1)[6]

  #     @expenses = current_user.expenses.new(
  #                                           batch_id: batch_no, 
  #                                           date: date, 
  #                                           category: category, 
  #                                           quantity: quantity, 
  #                                           unit_price: unit_price,
  #                                           description: description
  #                                         )
  #     @expenses.save
  #   end
  #   redirect_to expenses_path, notice: "Expenses imported"
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = current_user.expenses.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:date, :category, :quantity, :unit_price, :total_amount, :description, :batch_id)
    end
end

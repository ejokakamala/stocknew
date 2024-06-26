class FixedExpensesController < ApplicationController
  before_action :set_fixed_expense, only: %i[ show edit update destroy ]

  # GET /fixed_expenses or /fixed_expenses.json
  def index
    if params[:date_in_between]
      starts = params[:date_in_between].split(" - ").first
      starts_for_select = Date.strptime(starts, "%m/%d/%Y")
      ends = params[:date_in_between].split(" - ").second
      ends_for_select = Date.strptime(ends, "%m/%d/%Y")
      @fixed_expenses = current_user.fixed_expenses.where(date_in: starts_for_select..ends_for_select).page(params[:page])
      @total_fixed_expenses = @fixed_expenses.map(&:total).sum
      @searched_fixed_expenses = current_user.fixed_expenses.where(date: starts_for_select..ends_for_select)
      @total_searched_fixed_expenses = @searched_fixed_expenses.map(&:total).sum
    else
      #@fixed_expenses = FixedExpense.order(params[:id]).page(params[:page])
      @all_fixed_expenses = current_user.fixed_expenses.all  
      @total_all_fixed_expenses = @all_fixed_expenses.map(&:total).sum
      @fixed_expenses = @all_fixed_expenses.page(params[:page])
      @total_fixed_per_page = @fixed_expenses.map(&:total).sum
    end

    @title = "All Fixed Expenses"

    @exp = current_user.fixed_expenses.ransack(params[:q])
    respond_to do |format|
      format.html
      format.csv { send_data @exp.result.to_csv }
    end
  end

  # GET /fixed_expenses/1 or /fixed_expenses/1.json
  def show
  end

  # GET /fixed_expenses/new
  def new
    @fixed_expense = current_user.fixed_expenses.new
  end

  # GET /fixed_expenses/1/edit
  def edit
  end

  # POST /fixed_expenses or /fixed_expenses.json
  def create
    @fixed_expense = current_user.fixed_expenses.build(fixed_expense_params)

    respond_to do |format|
      if @fixed_expense.save
        format.html { redirect_to fixed_expense_url(@fixed_expense), notice: "Fixed expense was successfully created." }
        format.json { render :show, status: :created, location: @fixed_expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fixed_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fixed_expenses/1 or /fixed_expenses/1.json
  def update
    respond_to do |format|
      if @fixed_expense.update(fixed_expense_params)
        format.html { redirect_to fixed_expense_url(@fixed_expense), notice: "Fixed expense was successfully updated." }
        format.json { render :show, status: :ok, location: @fixed_expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fixed_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fixed_expenses/1 or /fixed_expenses/1.json
  def destroy
    @fixed_expense.destroy!

    respond_to do |format|
      format.html { redirect_to fixed_expenses_url, notice: "Fixed expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    FixedExpense.import(params[:file]) 
    redirect_to fixed_expenses_path, notice: "Fixed Expenses imported"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fixed_expense
      @fixed_expense = current_user.fixed_expenses.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fixed_expense_params
      params.require(:fixed_expense).permit(:date_in, :type_of_expense, :cost, :quantity, :total_cost, :description)
    end
end

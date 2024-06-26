require 'csv'

class IncomesController < ApplicationController
  before_action :set_income, only: %i[ show edit update destroy ]

  # GET /incomes or /incomes.json
  def index
    if params[:date_between]
      starts = params[:date_between].split(" - ").first
      starts_for_select = Date.strptime(starts, "%m/%d/%Y")
      ends = params[:date_between].split(" - ").second
      ends_for_select = Date.strptime(ends, "%m/%d/%Y")
      @incomes = current_user.incomes.where(date: starts_for_select..ends_for_select).page(params[:page])
      @total_incomes = @incomes.map(&:amount).sum
      @searched_incomes = current_user.incomes.where(date: starts_for_select..ends_for_select)
      @total_searched_incomes = @searched_incomes.map(&:amount).sum
    else
      @all_incomes = current_user.incomes.order(:batch_id)  
      @total_all_incomes = @all_incomes.map(&:amount).sum
      @incomes = @all_incomes.page(params[:page])
      @total_per_page = @incomes.map(&:amount).sum
    end

    @title = "All Incomes"

    @inc = current_user.incomes.ransack(params[:q])
    respond_to do |format|
      format.html
      format.csv { send_data @inc.result.to_csv }
    end
  end

  def import
    Income.import(params[:file]) 
    redirect_to incomes_path, notice: "Fixed Expenses imported"
  end

  # GET /incomes/1 or /incomes/1.json
  def show
  end

  # GET /incomes/new
  def new
    @income = current_user.incomes.new
  end

  # GET /incomes/1/edit
  def edit
  end

  # POST /incomes or /incomes.json
  def create
    @income = current_user.incomes.build(income_params)

    respond_to do |format|
      if @income.save
        format.html { redirect_to income_url(@income), notice: "Income was successfully created." }
        format.json { render :show, status: :created, location: @income }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incomes/1 or /incomes/1.json
  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to income_url(@income), notice: "Income was successfully updated." }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1 or /incomes/1.json
  def destroy
    @income.destroy!

    respond_to do |format|
      format.html { redirect_to incomes_url, notice: "Income was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income
      @income = current_user.incomes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def income_params
      params.require(:income).permit(:date, :category, :quantity, :unit_price, :total_amount, :description, :batch_id)
    end
end

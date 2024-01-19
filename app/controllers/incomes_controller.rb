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
      @incomes = Income.where(date: starts_for_select..ends_for_select)
    else
      @incomes = Income.order(:batch_id).page(params[:page])
    end

    @title = "All Incomes"

    @inc = Income.ransack(params[:q])
    respond_to do |format|
      format.html
      format.csv { send_data @inc.result.to_csv }
    end
  end

  # def import
  #   file = params[:file]
  #   return redirect_to incomes_path, notice: "Only CSV please" unless file.content_type = "text/csv"
  #   file = File.open(file)
  #   csv = CSV.parse(file, headers: true, col_sep: ';', quote_char: nil)
  #   csv.each do |row|
  #     #binding.b
  #     p row[0]
     
  #   end
  #   #Income.import(params[:file])
  #   redirect_to incomes_path, notice: "Income Data imported"
  # end


  #<div>
    #   <%= form_with url: import_incomes_path, method: :post do |form| %>
    #     <%= form.file_field :file %>     
    #     <%= form.submit "Import CSV" %>    
    #   <% end %>
    # </div>
  # GET /incomes/1 or /incomes/1.json
  def show
  end

  # GET /incomes/new
  def new
    @income = Income.new
  end

  # GET /incomes/1/edit
  def edit
  end

  # POST /incomes or /incomes.json
  def create
    @income = Income.new(income_params)

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
      @income = Income.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def income_params
      params.require(:income).permit(:date, :category, :quantity, :unit_price, :total_amount, :description, :batch_id)
    end
end

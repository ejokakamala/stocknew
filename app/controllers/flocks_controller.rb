class FlocksController < ApplicationController
  before_action :set_flock, only: %i[ show edit update destroy ]

  # GET /flocks or /flocks.json
  def index
    if params[:date_in_between]
      starts = params[:date_in_between].split(" - ").first
      starts_for_select = Date.strptime(starts, "%m/%d/%Y")
      ends = params[:date_in_between].split(" - ").second
      ends_for_select = Date.strptime(ends, "%m/%d/%Y")
      @flocks = Flock.where(date_in: starts_for_select..ends_for_select)
    else
      @flocks = Flock.order(:batch_id).page(params[:page])
    end

    @title = "All Flocks"

    @f = Flock.ransack(params[:q])
    respond_to do |format|
      format.html
      format.csv { send_data @f.result.to_csv }
    end
  end

  # GET /flocks/1 or /flocks/1.json
  def show
  end

  # GET /flocks/new
  def new
    @flock = Flock.new
  end

  # GET /flocks/1/edit
  def edit
  end

  # POST /flocks or /flocks.json
  def create
    @flock = Flock.new(flock_params)

    respond_to do |format|
      if @flock.save
        format.html { redirect_to flock_url(@flock), notice: "Flock was successfully created." }
        format.json { render :show, status: :created, location: @flock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flocks/1 or /flocks/1.json
  def update
    respond_to do |format|
      if @flock.update(flock_params)
        format.html { redirect_to flock_url(@flock), notice: "Flock was successfully updated." }
        format.json { render :show, status: :ok, location: @flock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flocks/1 or /flocks/1.json
  def destroy
    @flock.destroy!

    respond_to do |format|
      format.html { redirect_to flocks_url, notice: "Flock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    Flock.import(params[:file]) 
    redirect_to flocks_path, notice: "Flocks imported"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flock
      @flock = Flock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flock_params
      params.require(:flock).permit(:batch_no, :date_in, :retirement_date, :source, :initial_stock, :died_stock, :age, :notes, :status, :sold_stock, :batch_id)
    end
end

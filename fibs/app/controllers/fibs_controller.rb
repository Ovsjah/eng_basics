class FibsController < ApplicationController
  before_action :set_fib, only: [:show, :update, :destroy]

  # GET /fibs
  def index
    @fibs = Fib.all

    render json: @fibs
  end

  # GET /fibs/1
  def show
    render json: @fib
  end

  # POST /fibs
  def create
    @fib = Fib.new(fib_params)

    if @fib.save
      render json: @fib, status: :created, location: @fib
    else
      render json: @fib.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /fibs/1
  def update
    if @fib.update(fib_params)
      render json: @fib
    else
      render json: @fib.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fibs/1
  def destroy
    @fib.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fib
      @fib = Fib.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fib_params
      params.require(:fib).permit(:size)
    end
end

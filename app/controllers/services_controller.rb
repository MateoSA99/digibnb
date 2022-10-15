class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update destroy]
  def index
    if params[:query].present?
      sql_query = "product_name ILIKE :query OR description ILIKE :query"
      @services = Service.where(sql_query, query: "%#{params[:query]}%")
    else
      @services = Service.all
    end
  end

  def show
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    if @service.save
      redirect_to service_path(@service)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @service.update(service_params)
    redirect_to service_path(@service)
  end

  def destroy
    @service.destroy
    redirect_to services_path, status: :see_other
  end

  private

  def service_params
    params.require(:service).permit(:product_name, :description, :available, :price, :photo)
  end

  def set_service
    @service = Service.find(params[:id])
  end
end

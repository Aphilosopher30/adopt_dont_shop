class ApplicationsController < ApplicationController

  def index
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(application_params)
    application.progress = "in progress"

    application.save


    redirect_to "/applications/#{application.id}"

  end

  private #??????
   def application_params
    params.permit(:id, :name, :street_adress, :city, :state, :zip_code, :pitch)
   end

end

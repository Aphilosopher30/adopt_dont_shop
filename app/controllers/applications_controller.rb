class ApplicationsController < ApplicationController

  def index
  end

  def show
    @application = Application.find(params[:id])
    if params[:add_pet].present?
      @pets = Pet.search(params[:add_pet])
    else
      @pets = []
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    application.progress = "in progress"

    application.save

    redirect_to "/applications/#{application.id}"
  end

  def add_pet
    # binding.pry
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:app_id])
    application_pets = ApplicationPet.create(pet: pet, application: application)
    redirect_to "/applications/#{application.id}"
  end



  private #??????
   def application_params
    params.permit(:id, :name, :street_adress, :city, :state, :zip_code, :pitch)
   end

end

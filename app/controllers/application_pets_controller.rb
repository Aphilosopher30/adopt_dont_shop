class ApplicationPetsController < ApplicationController


  def create
#   binding.pry
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:app_id])
    application_pets = ApplicationPet.create(pet: pet, application: application)
    redirect_to "/applications/#{application.id}"
  end

end

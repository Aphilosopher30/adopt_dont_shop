class AdminController < ApplicationController

  def shelters
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
  end

  def application
    @application = Application.find(params[:id])
    @pets = @application.pets

  end

  def accept
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    @application_pet = pet.application_pets.find_by_sql("SELECT * FROM application_pets where application_id = #{application.id} AND pet_id = #{pet.id}").first

    @application_pet.approval = "approved"
    @application_pet.save

    redirect_to "/admin/applications/#{application.id}"
  end

  def reject
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    @application_pet = pet.application_pets.find_by_sql("SELECT * FROM application_pets where application_id = #{application.id} AND pet_id = #{pet.id}").first

    @application_pet.approval = "rejected"
    @application_pet.save

    redirect_to "/admin/applications/#{application.id}"  end


end

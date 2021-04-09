require 'rails_helper'

RSpec.describe 'admin can see an applications details' do

  it " it lists each pet on an application" do

    shelter_1 = Shelter.create!(name: "shelter_1", city: "greenvil", rank: "1", foster_program: "b")
    shelter_2 = Shelter.create!(name: "shelter_2", city: "burgerburg", rank:  "2", foster_program: "a")

    pet_1 = shelter_1.pets.create!(name: "alice", age: 1,  adoptable: true, breed: "corgy")
    pet_2 = shelter_1.pets.create!(name: "beatrice", age: 2,  adoptable: false, breed: "great dane")
    pet_3 = shelter_2.pets.create!(name: "albert", age: 3,  adoptable: true, breed: "great dane")
    pet_4 = shelter_2.pets.create!(name: "bob", age: 4,  adoptable: false, breed: "corgy")

    token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "not_in_progress")

    app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: token_app.id )
    app_pet_2 = ApplicationPet.create!(pet_id: pet_2.id, application_id: token_app.id )
    app_pet_3 = ApplicationPet.create!(pet_id: pet_3.id, application_id: token_app.id )

    visit "/admin/applications/#{token_app.id}"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
  end

  it " it shows approve button for the pets, but not if approved or rejected" do

    shelter_1 = Shelter.create!(name: "shelter_1", city: "greenvil", rank: "1", foster_program: "b")
    shelter_2 = Shelter.create!(name: "shelter_2", city: "burgerburg", rank:  "2", foster_program: "a")

    pet_1 = shelter_1.pets.create!(name: "alice", age: 1,  adoptable: true, breed: "corgy")
    pet_2 = shelter_1.pets.create!(name: "beatrice", age: 2,  adoptable: false, breed: "great dane")
    pet_3 = shelter_2.pets.create!(name: "albert", age: 3,  adoptable: true, breed: "great dane")
    pet_4 = shelter_2.pets.create!(name: "bob", age: 4,  adoptable: false, breed: "corgy")

    token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "not_in_progress")

    app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: token_app.id )
    app_pet_2 = ApplicationPet.create!(pet_id: pet_2.id, application_id: token_app.id )
    app_pet_3 = ApplicationPet.create!(pet_id: pet_3.id, application_id: token_app.id )


    visit "/admin/applications/#{token_app.id}"

    click_on "approve #{pet_1.name}"

    have_current_path("/admin/shelters/#{token_app.id}")

    expect(page).to have_content("approved")

  end


  it " it shows reject button for the pets, but not if approved or rejected" do
    shelter_1 = Shelter.create!(name: "shelter_1", city: "greenvil", rank: "1", foster_program: "b")
    shelter_2 = Shelter.create!(name: "shelter_2", city: "burgerburg", rank:  "2", foster_program: "a")

    pet_1 = shelter_1.pets.create!(name: "alice", age: 1,  adoptable: true, breed: "corgy")
    pet_2 = shelter_1.pets.create!(name: "beatrice", age: 2,  adoptable: false, breed: "great dane")
    pet_3 = shelter_2.pets.create!(name: "albert", age: 3,  adoptable: true, breed: "great dane")
    pet_4 = shelter_2.pets.create!(name: "bob", age: 4,  adoptable: false, breed: "corgy")

    token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "not_in_progress")

    app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: token_app.id )
    app_pet_2 = ApplicationPet.create!(pet_id: pet_2.id, application_id: token_app.id )
    app_pet_3 = ApplicationPet.create!(pet_id: pet_3.id, application_id: token_app.id )


    visit "/admin/applications/#{token_app.id}"

    click_on "reject #{pet_1.name}"

    visit "/admin/applications/#{token_app.id}"

    expect(page).to have_content("rejected")
  end


end

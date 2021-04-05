require 'rails_helper'

RSpec.describe ' application/:id page ' do

  it 'shows vet info' do

    shelter_1 = Shelter.create!(name: "shelter_1", city: "greenvil", rank: "1", foster_program: "b")
    shelter_2 = Shelter.create!(name: "shelter_2", city: "burgerburg", rank:  "2", foster_program: "a")

    pet_1 = shelter_1.pets.create!(name: "alice", age: 1,  adoptable: true, breed: "corgy")
    pet_2 = shelter_1.pets.create!(name: "beatrice", age: 2,  adoptable: false, breed: "great dane")
    pet_3 = shelter_2.pets.create!(name: "albert", age: 3,  adoptable: true, breed: "great dane")
    pet_4 = shelter_2.pets.create!(name: "bob", age: 4,  adoptable: false, breed: "corgy")

    veterinary_office_1 = VeterinaryOffice.create!(name: "vets R US", max_patient_capacity: 3, boarding_services: true)
    veterinary_office_2 = VeterinaryOffice.create!(name: "pet doctors", max_patient_capacity: 3, boarding_services: false)

    veterinarian_1 = veterinary_office_1.veterinarians.create!(on_call: true, review_rating: 4, name: "aaron")
    veterinarian_2 = veterinary_office_1.veterinarians.create!(on_call: false, review_rating: 5, name: "bree")
    veterinarian_3 = veterinary_office_2.veterinarians.create!(on_call: true, review_rating: 3, name: "charlot")
    veterinarian_4 = veterinary_office_2.veterinarians.create!(on_call: false, review_rating: 3, name: "devin")


    token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "not_in_progress")

    app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: token_app.id )
    app_pet_2 = ApplicationPet.create!(pet_id: pet_2.id, application_id: token_app.id )
    app_pet_3 = ApplicationPet.create!(pet_id: pet_3.id, application_id: token_app.id )


    visit "/applications/#{token_app.id}"

    expect(page).to have_content(token_app.street_adress)
    expect(page).to have_content("#{token_app.city}, #{token_app.state}")
    expect(page).to have_content(token_app.zip_code)
    expect(page).to have_content(token_app.pitch)
    expect(page).to have_content(token_app.progress)
  end





  # describe 'the pet new' do
  #   it 'renders the new form' do
  #     visit "/shelters/#{@shelter.id}/pets/new"
  #
  #     expect(page).to have_content('New Pet')
  #     expect(find('form')).to have_content('Name')
  #     expect(find('form')).to have_content('Breed')
  #     expect(find('form')).to have_content('Age')
  #     expect(find('form')).to have_content('Adoptable')
  #   end
  # end
  #
  # describe 'the pet create' do
  #   context 'given valid data' do
  #     it 'creates the pet and redirects to the shelter pets index' do
  #       visit "/shelters/#{@shelter.id}/pets/new"
  #
  #       fill_in 'Name', with: 'Bumblebee'
  #       fill_in 'Age', with: 1
  #       fill_in 'Breed', with: 'Welsh Corgi'
  #       check 'Adoptable'
  #       click_button 'Save'
  #       expect(page).to have_current_path("/shelters/#{@shelter.id}/pets")
  #       expect(page).to have_content('Bumblebee')
  #     end
  #   end
  #
  #   context 'given invalid data' do
  #     it 're-renders the new form' do
  #       visit "/shelters/#{@shelter.id}/pets/new"
  #
  #       click_button 'Save'
  #       expect(page).to have_current_path("/shelters/#{@shelter.id}/pets/new")
  #       expect(page).to have_content("Error: Name can't be blank, Age can't be blank, Age is not a number")
  #     end
  #   end
  # end
end

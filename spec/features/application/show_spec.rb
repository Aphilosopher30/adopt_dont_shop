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


    token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "in_progress")

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


  it 'has a text box to filter results by keyword if status is in process' do

    token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "in progress")

    visit "/applications/#{token_app.id}"
    expect(page).to have_button("Search")
  end

  it 'has a no text box to filter results by keyword if it is not in process' do

    token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "pending")

    visit "/applications/#{token_app.id}"
    expect(page).to have_no_button("Search")
  end

  it 'lists partial matches as search results' do

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "in progress")

    visit "/applications/#{token_app.id}"

    fill_in 'add_pet', with: "Ba"
    click_on("Search")

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end


  it 'add a pet to the page' do

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "in progress")

    visit "/applications/#{token_app.id}"

    fill_in 'add_pet', with: "Elle"
    click_on("Search")

    click_on("Adopt this Pet")

    expect(page).to have_content(pet_3.name)

  end

  describe "regarding submittion section " do

    it 'shows  submition button if there is atleast one pet on form' do

      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

      token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: nil, progress: "in progress")

      test_join = ApplicationPet.create!(pet: pet_1, application: token_app)

      visit "/applications/#{token_app.id}"

      expect(page).to have_content("in progress")

      fill_in 'pitch', with: "test justification"
      click_on("submit")

      expect(page).to have_content("test justification")
      expect(page).to have_content("pending")

    end

    it 'shows no submition button if there are no pets on form' do

      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

      token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: nil, progress: "in progress")

      visit "/applications/#{token_app.id}"

      expect(page).to have_no_button("why I would make a good owner for these pets")
    end
  end



end

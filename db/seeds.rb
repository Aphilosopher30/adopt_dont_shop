# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Application.destroy_all
ApplicationPet.destroy_all

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

require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it {should have_many :application_pets}
    it {should have_many(:applications).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end

  describe 'find_specific_app' do
    it 'returns the applicaiton_pet that matches the pet and a specific application number' do
      shelter_a = Shelter.create!(name: "shelter_1", city: "greenvil", rank: "1", foster_program: "b")

      pet_a = shelter_a.pets.create!(name: "alice", age: 1,  adoptable: true, breed: "corgy")

      token_app = Application.create!(name: "applicant", street_adress: "number street st", city: "burgerburg", state: "ST", zip_code: 555, pitch: "i cool", progress: "not_in_progress")

      app_pet_1 = ApplicationPet.create!(pet_id: pet_a.id, application_id: token_app.id )

      expect(pet_a.find_specific_app(token_app.id)).to eq(app_pet_1 )
    end
  end

end

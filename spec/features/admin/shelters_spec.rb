require 'rails_helper'

RSpec.describe 'admin shelters page' do

  it "has a place to list shelters" do
    shelter_1 = Shelter.create!(name: "abc pets", city: "greenvil", rank: "1", foster_program: "b")
    shelter_2 = Shelter.create!(name: "pets r us", city: "burgerburg", rank:  "3", foster_program: "a")
    shelter_3 = Shelter.create!(name: "zoo in the house", city: "burgerburg", rank:  "2", foster_program: "a")

    visit "/admin/shelters"


    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
  end

  it "  shelters are in reverse alphabetical order" do
    shelter_1 = Shelter.create!(name: "abc pets", city: "greenvil", rank: "1", foster_program: "b")
    shelter_2 = Shelter.create!(name: "pets r us", city: "burgerburg", rank:  "3", foster_program: "a")
    shelter_3 = Shelter.create!(name: "zoo in the house", city: "burgerburg", rank:  "2", foster_program: "a")

    visit "/admin/shelters"

    expect(page.all(".shelter")[2].text).to eq(shelter_1.name)
    expect(page.all(".shelter")[1].text).to eq(shelter_2.name)
    expect(page.all(".shelter")[0].text).to eq(shelter_3.name)
  end

end

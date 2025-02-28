require 'rails_helper'

RSpec.describe 'new application page' do

  it "has a place to " do

    visit "/applications/new"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('Street adress')
    expect(find('form')).to have_content('Zip code')
    expect(find('form')).to have_content('State')
  end

  it "does not move on without  " do

    visit "/applications/new"

    expect(page).to have_no_content("please fill in all fields")

    click_on 'Save'

    have_current_path("/applications/new")

    expect(page).to have_content("please fill in all fields")

  end

end

require 'rails_helper'

RSpec.describe 'new application page' do

  it "has a place to " do


    visit "/applications/new"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('street_adress')
    expect(find('form')).to have_content('zip_code')
    expect(find('form')).to have_content('state')
    expect(find('form')).to have_content('pitch')

  end

end

require 'rails_helper'

RSpec.describe Application, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:street_adress) }
    it { should validate_presence_of(:progress) }
    it { should validate_presence_of(:pitch) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
  end




end

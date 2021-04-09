class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true

  belongs_to :shelter
  has_many :application_pets, dependent: :delete_all #added extra stuff here, but not else where. WHY?
  has_many :applications,  through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def find_specific_app(application_id)
    @application_pet = self.application_pets.find_by_sql("SELECT * FROM application_pets where application_id = #{application_id} AND pet_id = #{self.id}").first
  end
end

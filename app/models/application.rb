class Application < ApplicationRecord
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :street_adress, presence: true
  validates :zip_code, presence: true, numericality: true
  # validates :pitch, presence: true
  # validates :progress, presence: true


  has_many :application_pets
  has_many :pets,  through: :application_pets

end

class Taco < ApplicationRecord

  enum meat: [ :chicken, :steak ]

  validates :meat, presence: true
  
end

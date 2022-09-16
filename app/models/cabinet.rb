class Cabinet < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :tools 
  has_many :spirits
  has_many :mixers
  has_many :garnishes
end

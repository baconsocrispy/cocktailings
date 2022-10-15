class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cabinets
  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe
  has_and_belongs_to_many :recipes
end

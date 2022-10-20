class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cabinets
  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe
  has_and_belongs_to_many :recipes

  # get a hash of ingredient ids from a user's cabinet
  def ingredients
    c = Cabinet.find(self.default_cabinet)
    ingredient_ids = []
    c.ingredients.each { |i| ingredient_ids << i.id }
    return ingredient_ids
  end

  def default_cab
    c = Cabinet.find(self.default_cabinet)
    return c
  end
end

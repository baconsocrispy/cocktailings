class Recipe < ApplicationRecord
  include Garnishable
  include Spiritable
  include Mixable
  include Toolable
  has_many :steps
  has_and_belongs_to_many :users

  def authors
    self.users
  end
  def add_author(author)
    self.users << author
  end
  def ingredients
    ingredients = []
    ingredients << self.garnishes
    ingredients << self.spirits
    ingredients << self.mixers

    return ingredients
  end
end

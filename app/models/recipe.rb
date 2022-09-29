class Recipe < ApplicationRecord
  include Garnishable
  include Spiritable
  include Mixable
  include Toolable
  has_many :steps, dependent: :destroy
  has_and_belongs_to_many :users
  has_one_attached :image
  # reject_if: :all_blank ensures blank steps aren't accidentally saved
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: :all_blank

  def authors
    self.users
  end
  def add_author(author)
    self.users << author
  end
  def ingredients
    ingredients = [*self.spirits, *self.mixers, *self.garnishes]
    return ingredients
  end
end

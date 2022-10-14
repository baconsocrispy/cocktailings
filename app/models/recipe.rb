class Recipe < ApplicationRecord
  include Toolable
  include Portionable
  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ingredients
  has_one_attached :image
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :portions, allow_destroy: true, reject_if: proc { |att| att['ingredient_id'].blank? }
  validates :name, presence: true

  def authors
    self.users
  end
  def add_author(author)
    self.users << author
  end
end

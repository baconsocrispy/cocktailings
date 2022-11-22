class Cabinet < ApplicationRecord
  before_validation :generate_slug

  include Portionable
  belongs_to :user, optional: true
  has_and_belongs_to_many :tools
  has_many :ingredients, through: :portions

  validates :name, presence: true 
  validates :slug, uniqueness: true, presence: true

  accepts_nested_attributes_for :portions, allow_destroy: true, reject_if: proc { |att| att['ingredient_id'].blank? }

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end
end

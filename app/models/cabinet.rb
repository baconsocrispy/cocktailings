class Cabinet < ApplicationRecord
  include Toolable
  include Portionable
  belongs_to :user, optional: true
  has_many :ingredients, through: :portions
  validates :name, presence: true 
  accepts_nested_attributes_for :portions, allow_destroy: true, reject_if: proc { |att| att['ingredient_id'].blank? }
end

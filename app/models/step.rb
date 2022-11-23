class Step < ApplicationRecord
  belongs_to :recipe
  validates :name, presence: true

  # automatically sets position when created
  acts_as_list
end

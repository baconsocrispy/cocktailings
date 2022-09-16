class Garnish < ApplicationRecord
  belongs_to :cabinet, optional: true
  belongs_to :recipe
end
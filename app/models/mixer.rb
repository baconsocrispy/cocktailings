class Mixer < ApplicationRecord
  belongs_to :cabinet, optional: true
end

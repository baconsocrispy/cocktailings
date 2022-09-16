class Tool < ApplicationRecord
  belongs_to :cabinet, optional: true
end

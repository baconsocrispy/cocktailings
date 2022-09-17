class Spirit < ApplicationRecord
  belongs_to :spiritable, :polymorphic => true
end

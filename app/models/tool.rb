class Tool < ApplicationRecord
  belongs_to :toolable, :polymorphic => true
end

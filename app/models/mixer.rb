class Mixer < ApplicationRecord
  belongs_to :mixable, :polymorphic => true
end

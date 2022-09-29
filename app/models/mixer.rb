class Mixer < ApplicationRecord
  belongs_to :mixable, :polymorphic => true

  def to_s
    self.mixer_type
  end
end

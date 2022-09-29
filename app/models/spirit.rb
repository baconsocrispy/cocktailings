class Spirit < ApplicationRecord
  belongs_to :spiritable, :polymorphic => true, optional: true

  def to_s
    self.spirit_type
  end
end

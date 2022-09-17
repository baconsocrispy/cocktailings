module Spiritable
  extend ActiveSupport::Concern

  included do 
    has_many :spirits, :as => :spiritable

    def add_spirit(spirit_type, amount)
      s = Spirit.create(:spiritable => self)
      s.spirit_type = spirit_type
      s.amount = amount.to_f
      s.save!
    end
  end
end
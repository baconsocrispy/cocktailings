module Mixable
  extend ActiveSupport::Concern

  included do
    has_many :mixers, :as => :mixable
    
    def add_mixer(mixer_type, amount)
      m = Mixer.create(:mixable => self)
      m.mixer_type = mixer_type
      m.amount = amount.to_f
      m.save!
    end
  end
end
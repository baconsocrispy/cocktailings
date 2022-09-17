# allows garnishes to be included in cabinets and recipes
module Garnishable
  extend ActiveSupport::Concern

  included do
    has_many :garnishes, :as => :garnishable

    def add_garnish(garnish_type, amount)
      g = Garnish.create(:garnishable => self)
      g.garnish_type = garnish_type
      g.amount = amount
      g.save!
    end
  end
end
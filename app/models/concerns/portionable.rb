module Portionable
  extend ActiveSupport::Concern

  included do
    has_many :portions, :as => :portionable
  end
end
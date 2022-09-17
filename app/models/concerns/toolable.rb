module Toolable
  extend ActiveSupport::Concern

  included do
    has_many :tools, :as => :toolable
  end
end
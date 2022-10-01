class Cabinet < ApplicationRecord
  include Toolable
  include Portionable
  has_and_belongs_to_many :users
end

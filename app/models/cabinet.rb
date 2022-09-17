class Cabinet < ApplicationRecord
  include Garnishable
  include Spiritable
  include Mixable
  include Toolable
  has_and_belongs_to_many :users

end

class PriceTable < ApplicationRecord
  belongs_to :shipping_company
  has_many :price_lines
end

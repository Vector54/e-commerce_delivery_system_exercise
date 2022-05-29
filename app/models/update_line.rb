class UpdateLine < ApplicationRecord
  belongs_to :order
  validates :coordinates, presence: true
  validates :coordinates, format: {with:  /\A((\-?|\+?)?\d+(\.\d+)?),\s*((\-?|\+?)?\d+(\.\d+)?)\z/, message: 'com formato inválido.'}
end

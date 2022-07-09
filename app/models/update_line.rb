# frozen_string_literal: true

class UpdateLine < ApplicationRecord
  belongs_to :order
  validates :coordinates, presence: true, format: { with: /\A((-?|\+?)?\d+(\.\d+)?),\s*((-?|\+?)?\d+(\.\d+)?)\z/ }
end

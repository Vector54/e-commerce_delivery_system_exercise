# frozen_string_literal: true

class Vehicle < ApplicationRecord
  belongs_to :shipping_company
  has_one :order, dependent: :destroy
  validates :plate, :brand_model, :weight_capacity, presence: true
end

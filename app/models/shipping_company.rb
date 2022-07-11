# frozen_string_literal: true

class ShippingCompany < ApplicationRecord
  validates :name, :corporate_name, :email_domain, :cnpj, :billing_adress, presence: true
  validates :cnpj, format: { with: %r{\A\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}\z} }
  validates :email_domain, format: { with: /\A([\w-]+\.)+[\w-]+\z/ }
  validates :cnpj, uniqueness: true
  has_many :users, dependent: :destroy
  has_one :price_table, dependent: :destroy
  has_one :delivery_time_table, dependent: :destroy

  after_create :set_delivery_time_table

  private

  def set_delivery_time_table
    DeliveryTimeTable.create(shipping_company: self)
  end
end

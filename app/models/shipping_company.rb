class ShippingCompany < ApplicationRecord
  validates :name, :corporate_name, :email_domain, :cnpj, :billing_adress, presence: true
  has_many :user, dependent: :destroy
  has_one :price_table
  has_one :delivery_time_table

  before_create :set_price_table, :set_delivery_time_table

  private

    def set_price_table
      PriceTable.new(shipping_company: self, minimum_value: 0)
    end
    
    def set_delivery_time_table
      DeliveryTimeTable.new(shipping_company: self)
    end
end

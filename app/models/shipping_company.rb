class ShippingCompany < ApplicationRecord
  validates :name, :corporate_name, :email_domain, :cnpj, :billing_adress, presence: true
  validates :cnpj, format: {with: /\A\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}\z/, message: 'está com formato inválido.'}
  validates :email_domain, format: {with: /\A([\w-]+\.)+[\w-]+\z/, message: 'deve ser palavras separadas por pontos.'}
  has_many :user, dependent: :destroy
  has_one :price_table
  has_one :delivery_time_table

  before_create :set_price_table, :set_delivery_time_table, :set_status

  private

    def set_price_table
      PriceTable.new(shipping_company: self, minimum_value: 0)
    end
    
    def set_delivery_time_table
      DeliveryTimeTable.new(shipping_company: self)
    end

    def set_status
      self.active = true
    end
end

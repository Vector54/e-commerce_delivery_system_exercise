class ShippingCompany < ApplicationRecord
  validates :name, :corporate_name, :email_domain, :cnpj, :billing_adress, presence: true
  has_many :user
end

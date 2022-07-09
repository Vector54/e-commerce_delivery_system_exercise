# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :shipping_company

  before_validation :set_sc

  private

  def set_sc
    sc_email_domains = ShippingCompany.pluck(:email_domain)
    self_email_domain = email.split('@').last

    if sc_email_domains.include?(self_email_domain)
      self.shipping_company = ShippingCompany.find_by(email_domain: self_email_domain)
    end
  end
end

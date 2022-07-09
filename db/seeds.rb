# frozen_string_literal: true
puts 'creating => admins'

unconfirmed_admin = Admin.create!(email: 'manoel_unconfirmed@sistemadefrete.com.br', password: '123456', name: 'Manoel')
confirmed_admin = Admin.create!(email: 'ligia_confirmed@sistemadefrete.com.br', password: '123456', name: 'Lígia').confirm

puts 'creating => shipping_companies'

inactive_shipping_company_1 = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                                      email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                                      billing_adress: 'Rua do Seu Carlos, 86', active: false)

inactive_shipping_company_2 = ShippingCompany.create!(name: 'Frete do Seu Meireles', corporate_name: 'FRETE DO SEU MEIRELES LTDA',
                                                      email_domain: 'seumeirelesfrete.com.br', cnpj: '06.902.995/0001-63',
                                                      billing_adress: 'Rua do Seu Meireles, 56', active: false)

active_shipping_company_1 = ShippingCompany.create!(name: 'Frete da Dona Catarina', corporate_name: 'FRETE DA DONA CATARINA LTDA',
                                                    email_domain: 'donacatarinafrete.com.br', cnpj: '06.902.995/0001-64',
                                                    billing_adress: 'Rua da Dona Catarina, 66')

active_shipping_company_2 = ShippingCompany.create!(name: 'Frete da Dona Paula', corporate_name: 'FRETE DA DONA PAULA LTDA',
                                                    email_domain: 'donapaulafrete.com.br', cnpj: '06.902.995/0001-65',
                                                    billing_adress: 'Rua da Dona Paula, 65')



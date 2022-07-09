# frozen_string_literal: true

$stdout.sync = true

puts 'creating => admins'.bg_green

unconfirmed_admin = Admin.create!(email: 'manoel_unconfirmed@sistemadefrete.com.br', password: '123456', name: 'Manoel')
print '.'.green
confirmed_admin = Admin.create!(email: 'ligia_confirmed@sistemadefrete.com.br', password: '123456',
                                name: 'Lígia').confirm
print ". DONE\n".green

puts 'creating => shipping_companies'.bg_green

inactive_shipping_company1 = ShippingCompany.create!(name: 'Frete do Seu João',
                                                     corporate_name: 'FRETE DO SEU JOÃO LTDA',
                                                     email_domain: 'seujoaofrete.com.br',
                                                     cnpj: '06.902.995/0001-62',
                                                     billing_adress: 'Rua do Seu João, 86',
                                                     active: false)
print '.'.green
inactive_shipping_company2 = ShippingCompany.create!(name: 'Frete do Seu Meireles',
                                                     corporate_name: 'FRETE DO SEU MEIRELES LTDA',
                                                     email_domain: 'seumeirelesfrete.com.br',
                                                     cnpj: '06.902.995/0001-63',
                                                     billing_adress: 'Rua do Seu Meireles, 56',
                                                     active: false)
print '.'.green
active_shipping_company1 = ShippingCompany.create!(name: 'Frete da Dona Catarina',
                                                   email_domain: 'donacatarinafrete.com.br',
                                                   corporate_name: 'FRETE DA DONA CATARINA LTDA',
                                                   cnpj: '06.902.995/0001-64',
                                                   billing_adress: 'Rua da Dona Catarina, 66')
print '.'.green
active_shipping_company2 = ShippingCompany.create!(name: 'Frete da Dona Paula',
                                                   email_domain: 'donapaulafrete.com.br',
                                                   corporate_name: 'FRETE DA DONA PAULA LTDA',
                                                   cnpj: '06.902.995/0001-65',
                                                   billing_adress: 'Rua da Dona Paula, 65')
print ". DONE\n".green

puts 'creating => users'.bg_green
puts 'OBS: initials are common and unique through owner and employees names'.red.bg_gray

# Frete do Seu João
user1 = User.create!(name: 'Jorge', email: 'jorge-email@seujoaofrete.com.br', password: '123456')
print '.'.green
user2 = User.create!(name: 'Jamily', email: 'Jamily-email@seujoaofrete.com.br', password: '123456')
print '.'.green
# Frete do Seu Meireles
user3 = User.create!(name: 'Morgana', email: 'morgana-email@seumeirelesfrete.com.br', password: '123456')
print '.'.green
user4 = User.create!(name: 'Maurício', email: 'maurício-email@seumeirelesfrete.com.br', password: '123456')
print '.'.green
# Frete da Dona Catarina
user5 = User.create!(name: 'Cassandra', email: 'cassandra-email@donacatarinafrete.com.br', password: '123456')
print '.'.green
user6 = User.create!(name: 'Claudio', email: 'claudio-email@donacatarinafrete.com.br', password: '123456')
print '.'.green
# Frete da Dona Paula
user7 = User.create!(name: 'Patrício', email: 'patrício-email@donapaulafrete.com.br', password: '123456')
print '.'.green
user8 = User.create!(name: 'Paloma', email: 'paloma-email@donapaulafrete.com.br', password: '123456')
print ". DONE\n".green

puts 'creating => price_lines'.bg_green

# Frete do Seu João
priceline1 = PriceLine.create!(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5,
                               maximum_weight: 50, value: 100,
                               price_table: PriceTable.find_by(shipping_company: inactive_shipping_company1))
print '.'.green
priceline2 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 5,
                               maximum_weight: 50, value: 150,
                               price_table: PriceTable.find_by(shipping_company: inactive_shipping_company1))
print '.'.green
# Frete do Seu Meireles
priceline3 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 5,
                               maximum_weight: 50, value: 100,
                               price_table: PriceTable.find_by(shipping_company: inactive_shipping_company2))
print '.'.green
priceline4 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 51,
                               maximum_weight: 150, value: 200,
                               price_table: PriceTable.find_by(shipping_company: inactive_shipping_company2))
print '.'.green
# Frete da Dona Catarina
priceline5 = PriceLine.create!(minimum_volume: 20, maximum_volume: 60, minimum_weight: 12,
                               maximum_weight: 60, value: 50,
                               price_table: PriceTable.find_by(shipping_company: active_shipping_company1))
print '.'.green
priceline6 = PriceLine.create!(minimum_volume: 61, maximum_volume: 120, minimum_weight: 12,
                               maximum_weight: 60, value: 150,
                               price_table: PriceTable.find_by(shipping_company: active_shipping_company1))
print '.'.green
# Frete da Dona Paula
priceline7 = PriceLine.create!(minimum_volume: 20, maximum_volume: 60, minimum_weight: 12,
                               maximum_weight: 60, value: 100,
                               price_table: PriceTable.find_by(shipping_company: active_shipping_company2))
print '.'.green
priceline8 = PriceLine.create!(minimum_volume: 20, maximum_volume: 60, minimum_weight: 61,
                               maximum_weight: 180, value: 250,
                               price_table: PriceTable.find_by(shipping_company: active_shipping_company2))
print ". DONE\n".green

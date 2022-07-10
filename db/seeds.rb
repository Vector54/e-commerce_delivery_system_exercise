# frozen_string_literal: true

$stdout.sync = true

puts 'creating => admins'.bg_green

unconfirmed_admin = Admin.create!(email: 'manoel_unconfirmed@sistemadefrete.com.br', password: '123456', name: 'Manoel')
print '.'.green
confirmed_admin = Admin.create!(email: 'ligia_confirmed@sistemadefrete.com.br', password: '123456', name: 'Lígia')
confirmed_admin.confirm
print ". DONE\n".green

puts 'creating => shipping_companies'.bg_green
puts 'OBS: two are inactive and two are active'.red.bg_gray

inactive_shipping_company1 = ShippingCompany.create!(name: 'Frete do Seu João',
                                                     corporate_name: 'FRETE DO SEU JOÃO LTDA',
                                                     email_domain: 'seujoaofrete.com.br',
                                                     cnpj: '06.902.995/0001-62',
                                                     billing_adress: 'Rua do Seu João, 86')
print '.'.green
inactive_shipping_company2 = ShippingCompany.create!(name: 'Frete do Seu Meireles',
                                                     corporate_name: 'FRETE DO SEU MEIRELES LTDA',
                                                     email_domain: 'seumeirelesfrete.com.br',
                                                     cnpj: '06.902.995/0001-63',
                                                     billing_adress: 'Rua do Seu Meireles, 56')
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

puts 'creating => delivery_time_lines'.bg_green

# Frete do Seu João
delivery_time_line1 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 100, delivery_time: 2,
                                               delivery_time_table:
                                               DeliveryTimeTable.find_by(shipping_company: inactive_shipping_company1))
print '.'.green
delivery_time_line2 = DeliveryTimeLine.create!(init_distance: 101, final_distance: 200, delivery_time: 4,
                                               delivery_time_table:
                                               DeliveryTimeTable.find_by(shipping_company: inactive_shipping_company1))
print '.'.green
# Frete do Seu Meireles
delivery_time_line3 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 50, delivery_time: 2,
                                               delivery_time_table:
                                               DeliveryTimeTable.find_by(shipping_company: inactive_shipping_company2))
print '.'.green
delivery_time_line4 = DeliveryTimeLine.create!(init_distance: 51, final_distance: 100, delivery_time: 4,
                                               delivery_time_table:
                                               DeliveryTimeTable.find_by(shipping_company: inactive_shipping_company2))
print '.'.green
# Frete da Dona Catarina
delivery_time_line5 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 60, delivery_time: 1,
                                               delivery_time_table:
                                               DeliveryTimeTable.find_by(shipping_company: active_shipping_company1))
print '.'.green
delivery_time_line6 = DeliveryTimeLine.create!(init_distance: 61, final_distance: 120, delivery_time: 3,
                                               delivery_time_table:
                                               DeliveryTimeTable.find_by(shipping_company: active_shipping_company1))
print '.'.green
# Frete da Dona Paula
delivery_time_line7 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 120, delivery_time: 1,
                                               delivery_time_table:
                                               DeliveryTimeTable.find_by(shipping_company: active_shipping_company2))
print '.'.green
delivery_time_line8 = DeliveryTimeLine.create!(init_distance: 121, final_distance: 240, delivery_time: 6,
                                               delivery_time_table:
                                               DeliveryTimeTable.find_by(shipping_company: active_shipping_company2))
print ". DONE\n".green

puts 'creating => vehicles'.bg_green

# Frete do Seu João
vehicle1 = Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                           weight_capacity: 8800, shipping_company: inactive_shipping_company1)
print '.'.green
vehicle2 = Vehicle.create!(plate: '7894-HGU', brand_model: 'Volksvagem - Charger 5.600', year: '2021',
                           weight_capacity: 11_000, shipping_company: inactive_shipping_company1)
print '.'.green
# Frete do Seu Meireles
vehicle3 = Vehicle.create!(plate: '4679-KJL', brand_model: 'Mercedes - CountryMan', year: '2018',
                           weight_capacity: 9400, shipping_company: inactive_shipping_company2)
print '.'.green
vehicle4 = Vehicle.create!(plate: '4948-FLS', brand_model: 'Scania - Evolution', year: '2010',
                           weight_capacity: 8500, shipping_company: inactive_shipping_company2)
print '.'.green
# Frete da Dona Catarina
vehicle5 = Vehicle.create!(plate: '3156-GSD', brand_model: 'VMAG - 7077', year: '1987',
                           weight_capacity: 7500, shipping_company: active_shipping_company1)
print '.'.green
vehicle6 = Vehicle.create!(plate: '7256-MHL', brand_model: 'Mercedes - Scrambler', year: '2023',
                           weight_capacity: 13_000, shipping_company: active_shipping_company1)
print '.'.green
# Frete da Dona Paula
vehicle7 = Vehicle.create!(plate: '4913-ALF', brand_model: 'Audi - Discovery', year: '2022',
                           weight_capacity: 12_000, shipping_company: active_shipping_company2)
print '.'.green
vehicle8 = Vehicle.create!(plate: '0302-GLO', brand_model: 'Volksvagem - Trooper 7.667', year: '2023',
                           weight_capacity: 12_500, shipping_company: active_shipping_company2)
print ". DONE\n".green

puts 'creating => orders'.bg_green
puts 'OBS: one order per status for each company (so four for each)'.red.bg_gray

# Frete do Seu João
order1 = Order.create!(admin: confirmed_admin, weight: 10, shipping_company: inactive_shipping_company1,
                       distance: 95, pickup_adress: 'Rua de Retirada, 45',
                       product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')
print '.'.green
order2 = Order.create!(admin: confirmed_admin, weight: 15, shipping_company: inactive_shipping_company1,
                       distance: 75, pickup_adress: 'Rua de Retirada, 45', vehicle_id: vehicle1.id,
                       product_code: 'SOMTHIN-ELSE', width: 4, height: 2, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'ativa')
print '.'.green
order3 = Order.create!(admin: confirmed_admin, weight: 40, shipping_company: inactive_shipping_company1,
                       distance: 150, pickup_adress: 'Rua de Retirada, 45', vehicle_id: vehicle1.id,
                       product_code: 'SOMTHIN-MORE', width: 2, height: 1, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'finalizada')
print '.'.green
order4 = Order.create!(admin: confirmed_admin, weight: 40, shipping_company: inactive_shipping_company1,
                       distance: 150, pickup_adress: 'Rua de Retirada, 45',
                       product_code: 'SOMTHIN-OTHER', width: 4, height: 2, depth: 5,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'cancelada')
inactive_shipping_company1.toggle(:active)
print '.'.green
# Frete do Seu Meireles
order5 = Order.create!(admin: unconfirmed_admin, weight: 700, shipping_company: inactive_shipping_company2,
                       distance: 95, pickup_adress: 'Rua de Retirada, 45',
                       product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')
print '.'.green
order6 = Order.create!(admin: confirmed_admin, weight: 15, shipping_company: inactive_shipping_company2,
                       distance: 75, pickup_adress: 'Rua de Retirada, 45', vehicle_id: vehicle1.id,
                       product_code: 'SOMTHIN-ELSE', width: 4, height: 2, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'ativa')
print '.'.green
order7 = Order.create!(admin: confirmed_admin, weight: 40, shipping_company: inactive_shipping_company2,
                       distance: 98, pickup_adress: 'Rua de Retirada, 45', vehicle_id: vehicle1.id,
                       product_code: 'SOMTHIN-MORE', width: 2, height: 1, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'finalizada')
print '.'.green
order8 = Order.create!(admin: confirmed_admin, weight: 40, shipping_company: inactive_shipping_company2,
                       distance: 26, pickup_adress: 'Rua de Retirada, 45',
                       product_code: 'SOMTHIN-OTHER', width: 4, height: 2, depth: 5,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'cancelada')
inactive_shipping_company2.toggle(:active)
print '.'.green
# Frete da Dona Catarina
order9 = Order.create!(admin: confirmed_admin, weight: 700, shipping_company: active_shipping_company1,
                       distance: 20, pickup_adress: 'Rua de Retirada, 45',
                       product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')
print '.'.green
order10 = Order.create!(admin: confirmed_admin, weight: 15, shipping_company: active_shipping_company1,
                        distance: 50, pickup_adress: 'Rua de Retirada, 45', vehicle_id: vehicle1.id,
                        product_code: 'SOMTHIN-ELSE', width: 4, height: 2, depth: 2,
                        delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'ativa')
print '.'.green
order11 = Order.create!(admin: confirmed_admin, weight: 40, shipping_company: active_shipping_company1,
                        distance: 75, pickup_adress: 'Rua de Retirada, 45', vehicle_id: vehicle1.id,
                        product_code: 'SOMTHIN-MORE', width: 2, height: 1, depth: 2,
                        delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'finalizada')
print '.'.green
order12 = Order.create!(admin: confirmed_admin, weight: 40, shipping_company: active_shipping_company1,
                        distance: 115, pickup_adress: 'Rua de Retirada, 45',
                        product_code: 'SOMTHIN-OTHER', width: 4, height: 2, depth: 5,
                        delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'cancelada')
print '.'.green
# Frete da Dona Paula
order9 = Order.create!(admin: confirmed_admin, weight: 700, shipping_company: active_shipping_company2,
                       distance: 50, pickup_adress: 'Rua de Retirada, 45',
                       product_code: 'SOMTHIN-098', width: 1, height: 3, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')
print '.'.green
order10 = Order.create!(admin: confirmed_admin, weight: 15, shipping_company: active_shipping_company2,
                        distance: 100, pickup_adress: 'Rua de Retirada, 45', vehicle_id: vehicle1.id,
                        product_code: 'SOMTHIN-ELSE', width: 4, height: 2, depth: 5,
                        delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'ativa')
print '.'.green
order11 = Order.create!(admin: confirmed_admin, weight: 60, shipping_company: active_shipping_company2,
                        distance: 170, pickup_adress: 'Rua de Retirada, 45', vehicle_id: vehicle1.id,
                        product_code: 'SOMTHIN-MORE', width: 2, height: 1, depth: 2,
                        delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'finalizada')
print '.'.green
order12 = Order.create!(admin: confirmed_admin, weight: 120, shipping_company: active_shipping_company2,
                        distance: 230, pickup_adress: 'Rua de Retirada, 45',
                        product_code: 'SOMTHIN-OTHER', width: 4, height: 2, depth: 5,
                        delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: 'cancelada')
print ". DONE\n".green

puts 'creating => update_lines'.bg_green

# Order 2
update_line1 = UpdateLine.create!(coordinates: '87.98465, 8.65498', order: order2)
print '.'.green
update_line2 = UpdateLine.create!(coordinates: '78.64895, 4.78985', order: order2)
print '.'.green
# Order 3
update_line3 = UpdateLine.create!(coordinates: '87.98465, 8.65498', order: order3)
print '.'.green
update_line4 = UpdateLine.create!(coordinates: '78.64895, 4.78985', order: order3)
print '.'.green
# Order 6
update_line5 = UpdateLine.create!(coordinates: '87.98465, 8.65498', order: order6)
print '.'.green
update_line6 = UpdateLine.create!(coordinates: '78.64895, 4.78985', order: order6)
print '.'.green
# Order 7
update_line7 = UpdateLine.create!(coordinates: '87.98465, 8.65498', order: order7)
print '.'.green
update_line8 = UpdateLine.create!(coordinates: '78.64895, 4.78985', order: order7)
print '.'.green
# Order 10
update_line9 = UpdateLine.create!(coordinates: '87.98465, 8.65498', order: order10)
print '.'.green
update_line10 = UpdateLine.create!(coordinates: '78.64895, 4.78985', order: order10)
print '.'.green
# Order 11
update_line11 = UpdateLine.create!(coordinates: '87.98465, 8.65498', order: order11)
print '.'.green
update_line12 = UpdateLine.create!(coordinates: '78.64895, 4.78985', order: order11)
print ". DONE\n".green

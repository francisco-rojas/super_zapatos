# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Store.create(name: 'Super Zapatos Limon', address: 'Somewhere en Limon')
Store.create(name: 'Super Zapatos Heredia', address: 'Somewhere en Heredia')
Store.create(name: 'Super Zapatos Guanacaste', address: 'Somewhere en Guanacaste')
Store.create(name: 'Super Zapatos Puntarenas', address: 'Somewhere en Puntarenas')

Article.create(name: 'Super Tennis', description: 'Nice confortable tennis', price: 127.43,
               total_in_shelf: 1, total_in_vault: 2, store_id: 1)
Article.create(name: 'Super Boots', description: 'Big shinny boots', price: 175.43,
               total_in_shelf: 2, total_in_vault: 3, store_id: 1)
Article.create(name: 'Super Sandals', description: 'Water proof sandals', price: 127.43,
               total_in_shelf: 5, total_in_vault: 1, store_id: 2)
Article.create(name: 'Super Shoes', description: 'Nice elegant shoes', price: 347.43,
               total_in_shelf: 2, total_in_vault: 3, store_id: 3)
Article.create(name: 'Super hiking boots', description: 'Big strong boots', price: 111.43,
               total_in_shelf: 1, total_in_vault: 5, store_id: 3)
Article.create(name: 'Super bowling shoes', description: 'Best antiskid shoes', price: 227.43,
               total_in_shelf: 1, total_in_vault: 5, store_id: 4)


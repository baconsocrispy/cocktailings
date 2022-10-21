# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'
require Rails.root.join('db', 'seed_recipe.rb')

# seed the database with ingredients 
csv_text = File.read(Rails.root.join('lib', 'seeds', 'ingredients.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  ingredient = Ingredient.where(:display_name => row['display_name'])
  if !ingredient.empty?
    ingredient.update!(type: row[0],
                      display_name: row['display_name'],
                      sub_type: row['sub_type'],
                      brand: row['brand'],
                      product: row['product'],
                      abv: row['abv'],
                      age: row['age'])
  
  else
    Ingredient.create!(type: row[0],
                      display_name: row['display_name'],
                      sub_type: row['sub_type'],
                      brand: row['brand'],
                      product: row['product'],
                      abv: row['abv'],
                      age: row['age'])
  end
end

universal_cabinet = Cabinet.find_by(:name => 'Universal Cabinet')

if universal_cabinet
  universal_cabinet.portions.destroy_all
  Ingredient.all.each do |i|
    portion = Portion.create!(ingredient_id: i.id,
                        portionable_type: 'Cabinet',
                        portionable_id: universal_cabinet.id)
    universal_cabinet.portions << portion
  end
else
  universal_cabinet = Cabinet.create!(name: 'Universal Cabinet')
  Ingredient.all.each do |i|
    portion = Portion.create!(ingredient_id: i.id,
                        portionable_type: 'Cabinet',
                        portionable_id: universal_cabinet.id)
    universal_cabinet.portions << portion
  end
  universal_cabinet.save!
end

text = File.read(Rails.root.join('lib', 'seeds', 'iliad.txt'))
iliad = text.split(' ')

seed_recipes(2000, iliad, 3)




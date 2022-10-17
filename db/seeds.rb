# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

# seed the database with ingredients 
csv_text = File.read(Rails.root.join('lib', 'seeds', 'ingredients.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |i|
  next if Ingredient.exists?(:display_name => i['display_name'])
  Ingredient.create(type: i['Type'],
                    display_name: i['display_name'],
                    sub_type: i['sub_type'],
                    brand: i['brand'],
                    product: i['product'],
                    abv: i['abv'],
                    age: i['age'])
end
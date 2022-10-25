# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'
require Rails.root.join('db', 'seed_ingredient.rb')
require Rails.root.join('db', 'universal_cabinet.rb')
require Rails.root.join('db', 'seed_categories.rb')
require Rails.root.join('db', 'seed_recipe.rb')

# populates ingredients table from ingredients csv
create_or_update_ingredients

# creates or updates the cabinet with all ingredients
# accessible by all users
create_or_reset_universal_cabinet

# populates categories table
seed_categories

# seeds arbitrary number of recipes with text pulled at random
# from a txt file to create a name of a max word length
# (# recipes, text, max word length)
text = File.read(Rails.root.join('lib', 'seeds', 'iliad.txt'))
iliad = text.split(' ')

seed_recipes(2000, iliad, 3)








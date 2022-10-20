# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

# seed the database with ingredients 
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'ingredients.csv'))
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   ingredient = Ingredient.where(:display_name => row['display_name'])
#   if !ingredient.empty?
#     ingredient.update!(type: row[0],
#                       display_name: row['display_name'],
#                       sub_type: row['sub_type'],
#                       brand: row['brand'],
#                       product: row['product'],
#                       abv: row['abv'],
#                       age: row['age'])
  
#   else
#     Ingredient.create!(type: row[0],
#                       display_name: row['display_name'],
#                       sub_type: row['sub_type'],
#                       brand: row['brand'],
#                       product: row['product'],
#                       abv: row['abv'],
#                       age: row['age'])
#   end
# end

# universal_cabinet = Cabinet.find_by(:name => 'Universal Cabinet')

# if universal_cabinet
#   universal_cabinet.portions.destroy_all
#   Ingredient.all.each do |i|
#     portion = Portion.create!(ingredient_id: i.id,
#                         portionable_type: 'Cabinet',
#                         portionable_id: universal_cabinet.id)
#     universal_cabinet.portions << portion
#   end
# else
#   universal_cabinet = Cabinet.create!(name: 'Universal Cabinet')
#   Ingredient.all.each do |i|
#     portion = Portion.create!(ingredient_id: i.id,
#                         portionable_type: 'Cabinet',
#                         portionable_id: universal_cabinet.id)
#     universal_cabinet.portions << portion
#   end
#   universal_cabinet.save!
# end

text = File.read(Rails.root.join('lib', 'seeds', 'iliad.txt'))
iliad = text.split(' ')

Recipe.destroy_all

1000.times do 
  r = Recipe.new
  i = []

  1.times do 
    num = rand(0...Spirit.all.length)
    i << Spirit.all[num]
  end

  5.times do
    num = rand(0...Ingredient.all.length)
    i << Ingredient.all[num]
  end

  i.each do |ing|
    r.portions.build(ingredient_id: ing.id)
  end
  
  words = ['']
  3.times do
    word = ''
    until word.length > 3
      num = rand(0...iliad.count)
      word = iliad[num]
    end
    words << word
  end

  separators = [' ', ' & ', ' of the ', ' and ', ' a la ']
  rand_words = []
  count = 0
  until rand_words.count == 3
    num = rand(0...words.count)
    word = words[num]
    if word.empty? && count == 0
      rand_words << word
      count += 1
    elsif !word.empty?
      rand_words << word
    end
  end
  rand_words.reject! { |w| w.empty? }

  name = ''

  rand_words.count == 2 ? 
    name = rand_words.join(separators[rand(0...separators.length)]) :
    name = rand_words.join(' ')

  r.name = name.titleize
  p r.name
  r.save!
end

p 'SEEDS SUCCESSFULLY RUN'
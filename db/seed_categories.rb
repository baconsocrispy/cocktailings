def seed_categories
  categories = File.read(Rails.root.join('lib', 'seeds', 'categories.txt'))
  categories.split("\n").each do |c|
    category = Category.find_by(name: c)
    Category.create!(name: c) unless category
  end
  p 'Categories successfully seeded'
end
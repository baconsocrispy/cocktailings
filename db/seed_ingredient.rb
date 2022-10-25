# seed the database with ingredients 
def create_or_update_ingredients
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
  p 'Ingredients Successfully Updated'
end
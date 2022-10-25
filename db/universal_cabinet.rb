# creates a cabinet with all ingredients accessible by all users
def create_or_reset_universal_cabinet
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
  p 'Universal Cabinet Successfully Updated'
end  
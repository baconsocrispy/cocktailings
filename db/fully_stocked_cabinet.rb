# creates a cabinet with all ingredients accessible by all users
def create_or_reset_fully_stocked_cabinet
  fully_stocked_cabinet = Cabinet.find_by(:name => 'Fully-Stocked Cabinet')

  if fully_stocked_cabinet
    fully_stocked_cabinet.portions.destroy_all
    Ingredient.all.each do |i|
      portion = Portion.create!(ingredient_id: i.id,
                          portionable_type: 'Cabinet',
                          portionable_id: fully_stocked_cabinet.id)
      fully_stocked_cabinet.portions << portion
    end
  else
    fully_stocked_cabinet = Cabinet.create!(name: 'Fully-Stocked Cabinet')
    Ingredient.all.each do |i|
      portion = Portion.create!(ingredient_id: i.id,
                          portionable_type: 'Cabinet',
                          portionable_id: fully_stocked_cabinet.id)
      fully_stocked_cabinet.portions << portion
    end
    fully_stocked_cabinet.save!
  end
  p 'Fully-Stocked Cabinet Successfully Updated'
end  
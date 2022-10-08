# since portions can be added to recipes or cabinets
# this helper function allows portions to be added to either
# model without duplicating logic. Nested loop shouldn't be
# a drain on resources since there will never be a large
# number of portions

# NEED TO RAISE/HANDLE AN ERROR WHEN AMOUNT == 0
class ApplicationController < ActionController::Base
  def process_portions(model, params)
    portion_hashes = params[:portions]
    portion_hashes.each do |portions|
      portions.each do |portion|

        # update if portion already exists
        if portion['id']
          Portion.find(portion['id']).update!(amount: portion['amount'],
                                              unit: portion['unit'])

        # create new portion if one does not exist
        else
          Portion.create(ingredient_id: portion['ingredient_id'], 
                        amount: portion['amount'], 
                        unit: portion['unit'],
                        portionable_id: model.id,
                        portionable_type: model.class,
                        )
        end
      end
    end
  end

  def process_steps(recipe, params)
    step_hashes = params[:steps]
    step_hashes.each do |steps|
      steps.each do |step|
        if step['id']
          Step.find(step['id']).update!(name: step['title'],
                                        description: step['description'])
        else
          if step['title'] || step['description']
            Step.create(name: step['title'],
                        description: step['description'],
                        recipe_id: recipe.id
            )  
          end                  
        end
      end
    end
  end
end


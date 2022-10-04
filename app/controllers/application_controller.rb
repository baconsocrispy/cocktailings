class ApplicationController < ActionController::Base
  def add_portions(model, params)
    portion_hashes = params[:portions]
    portion_hashes.each do |portions|
      portions.each do |portion|
        Portion.create(ingredient_id: portion['id'], 
                       amount: portion['amount'], 
                       unit: portion['unit'],
                       portionable_id: model.id,
                       portionable_type: model.class,
                      )
      end
    end
  end
end

module ApplicationHelper
  # returns cabinet with all ingredients
  def fully_stocked_cabinet
    Cabinet.find_by(name: 'Fully-Stocked Cabinet')
  end

  # returns user's default cabinet or fully-stocked cabinet
  def current_cabinet
    current_user ? 
      Cabinet.find(current_user.default_cabinet) :
      fully_stocked_cabinet
  end
end

module ApplicationHelper
  def current_cabinet
    current_user.default_cabinet ? 
      Cabinet.find(current_user.default_cabinet) :
      Cabinet.find_by(name: 'Fully-Stocked Cabinet')
  end
end

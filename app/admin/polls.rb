ActiveAdmin.register Poll do
  menu :parent => "Polls"
  
  index do
    column :question
    
    default_actions
  end
end

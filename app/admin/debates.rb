ActiveAdmin.register Debate do
  index do
    
    column :title
    column :description do |debate|
      if debate.description.length > 150
        debate.description.slice(0,150) + "..." 
      else
        debate.description
      end
    end
    column :user
    column :active do |comment|
      if comment.active == true
        raw("<span class='tag tactive'>YES</span>")
      else
        raw("<span class='tag tinactive'>NO</span>")
      end
    end

    default_actions
  end
  
  
  
  
end

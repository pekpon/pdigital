ActiveAdmin.register Event do
  index do
    
    column :title do |event|
      if event.title.length > 50
        event.title.slice(0,50) + "..." 
      else
        event.title
      end
    end
    column :description do |event|
      if event.description.length > 100
        event.description.slice(0,100) + "..." 
      else
        event.description
      end
    end
    column :location
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
ActiveAdmin.register Comment, :as => "Comentaris" do
  index do
    column :id
    column "Type", :commentable_type
    column "Comment", :body do |comment|
      if comment.body.length > 50
        comment.body.slice(0,50) + "..." 
      else
        comment.body
      end
    end
    column "Title", :commentable
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
  
  form do |f|
      f.inputs "Comment" do
          
          f.input :body
          f.input :active
          
      end
         f.buttons
  end
  
end

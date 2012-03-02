ActiveAdmin.register Article do
  	index do
  		column :title
  		column :author
  		column "Category", :category do |art|
  			art.category.name if art.category
  		end
  		default_actions
  	end
  
  	
  	form do |f|
        f.inputs "Article" do
            
            f.input :category
            f.input :title
            f.input :body, :input_html => { :class => "editor" }
            f.input :author
            f.input :image
            f.input :avatar
            f.input :published
            f.input :published_date, :as => :datepicker, :input_html => { :width => "50px" }
        end
           f.buttons
    end
    
    
end



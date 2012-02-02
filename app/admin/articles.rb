ActiveAdmin.register Article do
  	index do
  		column :title
  		column :body
  		column :author
  		column :published
  		column "Category", :category do |art|
  			art.category.name
  		end
  		default_actions
  	end
  	
  	form do |f|
        f.inputs "Article" do
            
            f.input :category
            f.input :title
            f.input :body
            f.input :author
            f.input :image
            f.input :published
            f.input :published_date, :as => :datepicker, :input_html => { :width => "50px" }
        end
           f.buttons
    end
    
    
end



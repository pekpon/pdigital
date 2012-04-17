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
            f.input :slug
            f.input :body, :input_html => { :class => "editor" }
            f.input :subtitle
            f.input :author
            #f.input :image, :hint => f.template.image_tag(f.object.image.url(:thumb))
            #f.input :image_2, :hint => f.template.image_tag(f.object.image_2.url(:thumb))
            #f.input :image_3, :hint => f.template.image_tag(f.object.image_3.url(:thumb))
            #f.input :image_4, :hint => f.template.image_tag(f.object.image_4.url(:thumb))
            f.input :published
            f.input :published_date, :as => :datepicker, :input_html => { :width => "50px" }
            
        end
           f.buttons
    end
    
    
end



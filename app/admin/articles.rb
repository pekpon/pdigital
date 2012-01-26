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
end

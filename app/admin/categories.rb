ActiveAdmin.register Category do
  menu :parent => "Articles"
  
  index do
		column :id
		column :name
		column "Num. Articles" do |cat|
			cat.articles.count
		end
		
		default_actions
	end
end

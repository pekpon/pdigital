module CategoriesHelper
  
  def show_categories(cat,column)
    
		cat.each_with_index do |category , index| 
		
			 if (index-column)%3 == 0
			   puts index
			 end 
			
		end 

  end

end

		#<h1><%= link_to category.name, category_path(category) %></h1>
		#<p>There are <%= category.articles.count %> articles in this category</p>
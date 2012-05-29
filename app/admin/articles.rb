ActiveAdmin.register Article do
  
  menu :parent => "Articles"
  
  	index do
  		column :title
  		column :author
  		column "Category", :category do |art|
  			art.category.name if art.category
  		end
  		column "Total Views" do |article|
  			article.views_filtered_by_ip
  		end
  		column "Ip Views" do |article|
  			article.impressionist_count(:filter => :ip_address)
  		end
  		default_actions
  	end
  
  	
  	form do |f|
        f.inputs "Article" do
            
            f.input :category
            f.input :title
            f.input :subtitle
            f.input :body, :input_html => { :class => "editor" }
            f.input :article_resume
            f.input :author
            f.input :published
            f.input :published_date, :as => :datepicker, :input_html => { :width => "50px" }
            
        end
           f.buttons
    end
    
    controller do
      
      def create
        @article = Article.new(params[:article])

        #respond_to do |format|
          if @article.save
            RealTime.create! :trackeable_id => @article.id, :trackeable_type => "Article"
            redirect_to(admin_articles_path) 
          else
            render active_admin_template('edit.html.arb'), :layout => false
          end
       #end
        
      end
      
    end
    
    
end



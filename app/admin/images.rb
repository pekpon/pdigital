ActiveAdmin.register Image do
  index do
		column "Image" do |img|
      image_tag(img.image.url(:thumb),:class => "img_thumb")
    end
		column "Article" do |post|
      post.article.title
    end
		default_actions
	end
  
  form do |f|
      f.inputs "Image" do         
          f.input :article
          f.input :image, :hint => f.template.image_tag(f.object.image.url(:thumb))
      end
         f.buttons
  end
end
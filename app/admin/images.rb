ActiveAdmin.register Image do
  menu :parent => "Media"
  index do
		column "Image" do |img|
      image_tag(img.image.url(:thumb),:class => "img_thumb")
    end
		column "Article" do |post|
      unless post.article.nil?
        post.article.title
      else
        "Imatge ZOMBIE, sense noticia"
      end
    end
		default_actions
	end
  
  form do |f|
      f.inputs "Image" do         
          f.input :article
          f.input :image_foot
          f.input :aux
          f.input :image, :hint => f.template.image_tag(f.object.image.url(:thumb))
      end
         f.buttons
  end
end
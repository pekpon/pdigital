ActiveAdmin.register Video do
  menu :parent => "Media"
  index do
		column "Video" do |video|
    raw("<iframe width='200' height='120' src='http://www.youtube.com/embed/#{video.youtube_code}?rel=0' frameborder='0' allowfullscreen></iframe>")
    end
		column "Article" do |post|
      post.article.title
    end
		default_actions
	end
  
  form do |f|
      f.inputs "Video" do         
          f.input :article
          f.input :youtube_code
          f.input :width
          f.input :height
      end
         f.buttons
  end
end
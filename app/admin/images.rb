ActiveAdmin.register Image do
  form do |f|
      f.inputs "Image" do         
          f.input :article
          f.input :image, :hint => f.template.image_tag(f.object.image.url(:thumb))
      end
         f.buttons
  end
end
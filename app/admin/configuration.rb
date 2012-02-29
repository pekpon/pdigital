ActiveAdmin.register Configuration do
	form do |f|
        f.inputs "Configuration" do
            f.input :key
            f.input :values
            f.input :image
        end
        f.buttons
    end
  
end

ActiveAdmin.register Configuration do
  index do
		column :key
		column :values
		default_actions
	end
	
	form do |f|
        f.inputs "Configuration" do
            f.input :key
            f.input :values
            f.input :image
        end
        f.buttons
    end
  
end

ActiveAdmin.register Commerce do
  
  form do |f|
      f.inputs "Commerce" do         
          f.input :name
          f.input :street
          f.input :telephone
          f.input :email
          f.input :web
          f.input :schedule
          f.input :map_code
          f.input :image
          f.input :active
          f.input :pro
          
      end
         f.buttons
  end
  
end

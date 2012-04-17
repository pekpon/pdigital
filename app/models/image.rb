class Image < ActiveRecord::Base
  belongs_to :article
  
  #paperclip image
	has_attached_file :image, :styles => { :detail => "610x610>", :medium => "330x330>", :thumb => "100x100>" },
      :url => "/system/images/:id/:style/:basename.:extension",          
      :path => ":rails_root/public/system/images/:id/:style/:basename.:extension"
end

class Image < ActiveRecord::Base
  belongs_to :article
  
  validates :image_foot, :length => { :maximum => 250 }
  
  #paperclip image
	has_attached_file :image, :styles => { :detail => "610x610>", :medium => "330x330>", :facebook => "200x200#", :thumb => "90x90#" },
      :url => "/system/images/:id/:style/:basename.:extension",          
      :path => ":rails_root/public/system/images/:id/:style/:basename.:extension"
end

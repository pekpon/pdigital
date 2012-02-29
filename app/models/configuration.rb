class Configuration < ActiveRecord::Base
	has_attached_file :image, 
      :url => "/system/configurations/:id/:basename.:extension",          
      :path => ":rails_root/public/system/configurations/:id/:basename.:extension"

    def self.image_url key
      data = self.find_by_key! key.to_s
      if data
        unless data.image_file_name.nil?
           data.image.url
        else
          data.values
        end
      end
    end
end

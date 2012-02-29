class Configuration < ActiveRecord::Base
	has_attached_file :image, :styles => { 
        :detail => "610x610>",
        :medium => "330x330>",
        :thumb => "100x100>" }
end

class Article < ActiveRecord::Base
	belongs_to :category
	has_many :article_comments
	is_impressionable
	
	has_attached_file :avatar, :styles => { :detail => "610x610>", :medium => "330x330>", :thumb => "100x100>" },
      :url => "/system/avatars/:id/:style/:basename.:extension",          
      :path => ":rails_root/public/system/avatars/:id/:style/:basename.:extension"
	
    validates :category, :presence => true
    validates :body, :presence => true
    validates :title, :presence => true
    validates :published_date, :presence => true

    def self.damedato
      numbers = []
      self.all.each { |x| numbers << {:id => x.id,  :count => x.article_comments.count} }
      sorted = numbers.sort! {|x,y| y[:count] <=> x[:count] }
      ids =[]
      sorted[0..4].each{|x| ids << x[:id] }
      Article.find(ids)
    end
	
    def resume
      Sanitize.clean(self.body).slice!(0,200)
    end

    def vote(type, ip)
      self.votes.create! :vote_type => type, :ip => ip
    end

    def vots_result
      positive = self.votes.where(:vote_type => 1)
      negative = self.votes.where(:vote_type => 2)
      total = positive.count - negative.count
      return total
    end

    def voted(ip)
      voted = self.votes.where(:ip => ip)
      if voted.count == 0
        return false
      else
        return true
      end
    end
	
end

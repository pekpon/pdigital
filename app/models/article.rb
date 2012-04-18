class Article < ActiveRecord::Base
	belongs_to :category
	has_many :article_comments
	has_many :images
	is_impressionable
	
	extend FriendlyId
  friendly_id :title, :use => :slugged

  def should_generate_new_friendly_id?
      self.slug.blank? or (new_record? and self.slug.blank?)
  end
	
    validates :category, :body, :title, :published_date, :presence => true
    validates :body, :length => { :minimum => 10 }
    validates :title, :length => { :in => 3...160 }
    validates :published_date, :format => { :with => /\d{4}-\d{2}-\d{2}/ }
    validates :subtitle, :length => { :maximum => 160 }

    def self.get_comments(method=:views_filtered_by_ip)
      ########## FIX ###########
      self.all.sort_by{|x| -x.try(method) }[0..9]
      # numbers = []
      # self.all.each { |x| numbers << {:id => x.id,  :count => x.try(method), :article => x} }
      # sorted = numbers.sort! {|x,y| y[:count] <=> x[:count] }
      # ids =[]
      # sorted[0..9].each{|x| ids << x[:article] }
      # ids
    end

    def self.active
      self.where(:published => true)
    end

    def self.category cat
      self.where(:category_id => cat)
    end
    
    def self.general(cat1, cat2)
      self.where("category_id != ? and category_id != ?",cat1,cat2)
    end
	
	  #Number
	  def views_filtered_by_ip
	    self.impressions.count
	  end
	  
	  def save_visits_by_ip
	    self.views_filtered_by_ip = self.impressionist_count(:filter => :ip_address)
	    self.save!
	  end

	  #Number
	  def comments_count
	    self.article_comments.count
	  end
	  
	  def stats_yesterday
	      comments = self.article_comments.where(:created_at => (Time.now.midnight - 1.day)..Time.now.midnight)
  	    c = comments.count
  	    v = 0
	    
  	    comments.each do |comment|
  	      v = v + comment.votes.count
        end
      
  	    i = self.impressionist_count(:filter => :ip_address, :start_date => "#{Date.yesterday}", :end_date => "#{Date.today}")

  	    c*10 + v*5 + i
	  end
    	
    def resume
      if self.article_resume.nil? or self.article_resume.empty?
        Sanitize.clean(self.body).slice!(0,160) + "..."
      else
        self.article_resume
      end
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
    
    def self.most_moved
      if !$stats_yesterday.present? or $stats_yesterday[:date].day != Time.now.day
        a = Article.first
      
        self.all.each do |x|
          a = x if x.try(:stats_yesterday) >= a.try(:stats_yesterday)
        end
      
        $stats_yesterday = { :data => a, :date => Time.now }
      end
      $stats_yesterday[:data].reload
    end
end

class Article < ActiveRecord::Base
	belongs_to :category
	has_many :comments, :as => :commentable
	has_many :images
	has_many :videos
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
      self.all.sort_by{|x| -x.try(method) }[0..9]
    end
    
    ############################
    def views_day
	    self.impressions.where(:created_at => (Date.today.beginning_of_day)..(Date.today.end_of_day)).count
	  end
	  
	  def comments_day
	   self.comments.where(:created_at => (Date.today.beginning_of_day)..(Date.today.end_of_day)).count
	  end
	  
	  def views_month
	    self.impressions.where(:created_at => (Date.today-30.days)..(Date.today)).count
	  end
	  
	  def comments_month
	   self.comments.where(:created_at => (Date.today-30.days)..(Date.today)).count
	  end
	  ##########################

    def self.active
      self.where(:active => true)
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
	    self.comments.count
	  end
	  
	  def stats_yesterday
	      comments = self.comments.where(:created_at => (Date.yesterday.beginning_of_day)..(Date.yesterday.end_of_day))
	      impressions = self.impressionist_count(:filter => :ip_address, :start_date => "#{Date.yesterday.beginning_of_day}", :end_date => "#{Date.yesterday.end_of_day}")
  	    
  	    v = 0
  	    comments.each do |comment|
  	      v = v + comment.votes.count
        end
        
        c = comments.count
  	   
  	    c*10 + v*5 + impressions
	  end
    	
    def resume
      if self.article_resume.blank?
        Sanitize.clean(self.body.gsub(/\[\w+\]/,'')).slice!(0,160) + "..."
      else
        self.article_resume
      end
    end
    def prepared
      #Select all aux images
      images = self.aux_images
      videos = self.videos
      body = self.body
      
      #Change text parts
      images.each_with_index do |aux_img,index|
        body = body.gsub("[img#{index}r]", "<img class='aux_image right' src='"+aux_img.image.url(:medium)+"'") 
        body = body.gsub("[img#{index}l]", "<img class='aux_image left' src='"+aux_img.image.url(:medium)+"'") 
      end
      
      #Video
      videos.each_with_index do |video,index|
        width = video.width
        height = video.height
        
        if width.nil? or height.nil?
          width = 600
          height = 355
        end
        
        body = body.gsub("[video#{index}]", "<iframe width='#{width}' height='#{height}' src='http://www.youtube.com/embed/#{video.youtube_code}?rel=0' frameborder='0' allowfullscreen></iframe>") 
        
      end
      
      return body
    end
    
    def standar_images
      self.images.where(:aux => false)
    end
    
    def aux_images
      self.images.where(:aux => true)
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
    
    def day
      self.published_date.day()
    end
    
    def month
      t = self.published_date
      t.strftime("%B")
    end
    
    def year
      self.published_date.year()
    end
    
    def search(string)
      response = true
      
      if string.present?
        search = string.split(' ')
        ok_words = []
        search.each do |word|
          if word.length > 3
             ok_words << word.downcase
          end
        end
        
        if ok_words == []
          response = false
        end

        ok_words.each_with_index do |word,index|
          response = false if self.title.downcase.exclude? word
        end
      else
        response = false
      end
      
      
      return response
    end
end

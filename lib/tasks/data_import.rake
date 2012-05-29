begin
 require 'csv'
rescue
  puts "CSV not founded"
end
desc "Migrate activity"
task :migrate_activity => :environment do
  @objects = Article.where( :created_at => (Time.now-48.hours)..(Time.now), :published => true  )
  @objects = @objects + Debate.where( :created_at => (Time.now-48.hours)..(Time.now), :active => true )
  @objects = @objects + Event.where( :created_at => (Time.now-48.hours)..(Time.now), :active => true )
      
  @objects = @objects + Comment.where( :created_at => (Time.now-48.hours)..(Time.now), :active => true )
  @objects = @objects + Vote.where( :created_at => (Time.now-48.hours)..(Time.now) )
      
  @votes = Vote.where(:created_at => (Time.now-48.hours)..(Time.now) )
      
  @objects.sort! {|x,z| x.created_at <=> z.created_at}
  
  @objects.each do |object|
    RealTime.create! :trackeable_id => object.id, :trackeable_type => object.class.to_s, :created_at => object.created_at
    puts "ok"
  end
end

desc "Migrate comments"
task :migrate_comments => :environment do
  Comment.delete_all
     ArticleComment.all.each do |c|
       comment = Comment.create :body => c.comment, 
                       :user_id => c.user_id, 
                       :commentable_id => c.article_id,
                       :commentable_type => "Article",
                       :created_at => c.created_at,
                       :username => c.username,
                       :active => c.active
                       
      puts "comment #{comment.id}"
      
      c.votes.each do |v|
        v.comment = comment
        v.save!
      end 
  end
end

desc "Migrate polls"
task :migrate_polls => :environment do
  Poll.delete_all
  PollOption.delete_all
  PollVote.delete_all
  
  #Read the poll file
  polls = CSV.read("../data/enquestes.csv",:col_sep => ";")
  polls_options = CSV.read("../data/enquesta_opcions.csv",:col_sep => ";")
  polls_votes = CSV.read("../data/enquesta_vots.csv",:col_sep => ";")

  p = {}
  polls.each do |poll|
    poll_id = poll[0]
    p[poll_id] = Poll.create(:question => poll[1])
  end
  
  o = {}  
  polls_options.each do |option|
    option_id = option[0]
    o[option_id] = PollOption.create(:option => option[2], :poll => p[option[1]])
  end
      
  polls_votes.each do |vote|
    p[vote[1]].vote(o[vote[2]].id,vote[4])
  end
end

desc "Migrate articles,comments and votes"
task :migration => :environment do
  Article.delete_all
  ArticleComment.delete_all
  Impression.delete_all
  Image.delete_all
  
  #Save users
  users = {}
  CSV.foreach("../data/usuaris.csv",:col_sep => ";") { |row| users = users.merge( { row[0] => row[1] } ) }
  
  #Save comments
  comments = CSV.read("../data/comentaris.csv",:col_sep => ";")
  
  #Save impressions
  impressions = CSV.read("../data/lectures_noticies.csv",:col_sep => ";")
  
  #Save votes
  votes = CSV.read("../data/votacions_comentaris.csv",:col_sep => ";")
  
  #Read the news file
  CSV.foreach("../data/noticies.csv",:col_sep => ";") do |row|
  
  case row[6].to_i
    when 1
      cat = 11
    when 2
      cat = 1
    when 3
      cat = 10
    when 4
      cat = 7
    when 5
      cat = 5
    when 6
      cat = 8
    when 7
      cat = 4
    when 8
      cat = 2
    when 9
      cat = 6
    when 10
      cat = 9
    when 11
      cat = 3
    else
      cat = 11
  end
      
  if row[14].to_i == 1
    act = true
  else
    act = false
  end    
   
  begin 
  article = Article.create(:title => row[2].gsub(/\\#/, '"'), :body => row[4].gsub(/\\#/, '"'), :author => row[7],
      :category => Category.find(cat), :published_date => row[8], :published => act)
      
    puts row[0]
  rescue
    puts "#{row[0]} - error"
  end
    
    #Insertamos la imagen
    if (File.exists?("../data/img/#{row[9]}"))
      image = Image.new
      image.image = File.new("../data/img/#{row[9]}") 
      article.images << image
    end

    article.save

    id_old = row[0]
    old_user = "usuari"
    
    #RECORREMOS LAS VISITAS
    impressions.each do |view|
      if id_old == view[1] #id del articulo
        
        begin
        impression = Impression.create(:impressionable_type => "Article", 
        :impressionable_id => article.id, :controller_name => "articles", 
        :action_name => "show", :ip_address => view[4])
        rescue
          "error con impresion"
        end
      
      end
    end
    
    #RECORREMOS LOS COMENTARIOS
    #comments
    comments.each do |row2|
      
    #RECORREMOS LOS USUARIOS   
    if row2[2].to_i != 0
      old_user = users[row2[2].to_s]
    end

    #Creamos el comentario con el campo de usuario vacio y un nuevo campo user_old con el nombre
    if id_old == row2[1]
      content = row2[5].gsub(/\\\$/, '"')
      if content.length < 10000
        puts "-> #{row2[0]}"
        begin
        a_comment = article.article_comments.create(:comment => content, 
          :user => nil, 
          :username => old_user,
          :active => row2[3])
        rescue
          puts "error comentario"
        end
      end
    end
    
    id_comment_old = row2[0]
    
    #RECORREMOS LOS VOTOS
     #votes
     votes.each { |row4| 
        begin
         a_comment.vote(row4[2].to_i == 0 ? 2 : 1,row4[3]) if id_comment_old == row4[1] and a_comment != nil and a_comment.votes
        rescue
          puts "already taken #{row4[3]}"
        end
     }
    end
  end
end

desc "Migrate users"
task :migrate_users => :environment do
  User.delete_all
  CSV.foreach("../data/usuaris.csv",:col_sep => ";") do |row|
    begin
      u = User.new({:email => row[7], :password => "111111", :password_confirmation => "111111", :username => row[1] })
      u.confirm!
      u.skip_confirmation!
      u.save
      u.send_reset_password_instructions
      puts row[0]
    rescue
      puts "error"
    end
  end
end

desc "Change AUX value for images"
task :images_aux => :environment do
  x = Image.all
  x.each do |image|
    image.aux = false
    image.save
  end
end
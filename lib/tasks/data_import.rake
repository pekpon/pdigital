require 'CSV'

desc "Migrate polls"
task :migrate_polls => :environment do
  Poll.delete_all
  PollOption.delete_all
  PollVote.delete_all
  
  #Read the poll file
  polls = CSV.read("../data/enquestes.csv",:col_sep => ";")
  polls_options = CSV.read("../data/enquesta_opcions.csv",:col_sep => ";")
  polls_votes = CSV.read("../data/enquesta_vots.csv",:col_sep => ";")

  polls.each do |row|
    old_poll_id = row[0].to_i
    poll = Poll.create(:question => row[1])
    
    polls_options.each do |row2|
      old_poll_option_id = row2[0].to_i
      
      poll_option = PollOption.create(:option => row2[2], :poll => poll) if row2[1].to_i == old_poll_id
        
      polls_votes.each do |row3| 
        poll.vote(poll_option.id,row3[4]) if row3[2].to_i == old_poll_option_id
      end
    end
  end
end

desc "para hacer test"
task :pruebas => :environment do
  Article.delete_all
  ArticleComment.delete_all
  
  #Save users
  users = {}
  CSV.foreach("../data/usuaris.csv",:col_sep => ";") { |row| users = users.merge( { row[0] => row[1] } ) }
  
  #Save comments
  comments = CSV.read("../data/comentaris.csv",:col_sep => ";")
  
  #Save votes
  votes = CSV.read("../data/votacions.csv",:col_sep => ";")
  
  #Read the news file
  CSV.foreach("../data/noticies_validas.csv",:col_sep => ";") do |row|
  
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
      
    
  article = Article.create(:title => row[2], :body => row[4].gsub(/\#/, '"'), :author => row[7],
      :category => Category.find(cat), :published_date => row[8])
      
    #Insertamos la imagen
    article.image = File.new("../data/img/#{row[9]}") if File.exists?("../data/img/#{row[9]}")
   # article.img.attachment = File.open("../data/img/#{row[9]}")
    #article.image = File.read("../data/img/#{row[9]}")
    article.save

    id_old = row[0]
    old_user = "usuari"
   
    #RECORREMOS LOS COMENTARIOS
    comments.each do |row2|
      
    #RECORREMOS LOS USUARIOS   
    if row2[2].to_i != 0
      old_user = users[row2[2].to_s]
    end
        
    #Creamos el comentario con el campo de usuario vacio y un nuevo campo user_old con el nombre
    a_comment = article.article_comments.create(:comment => row2[5].gsub(/\$/, '"'), 
      :user => nil, 
      :username => old_user,
      :active => row2[3]) if id_old == row2[1]
    
    id_comment_old = row2[0]
    
    #RECORREMOS LOS VOTOS
     votes.each { |row4| 
       a_comment.vote(row4[2].to_i == 0 ? 2 : 1,"0.0.0.0") if id_comment_old == row4[1] and a_comment != nil
     }
    end
  end
end

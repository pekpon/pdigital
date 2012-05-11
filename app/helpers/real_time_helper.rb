module RealTimeHelper
  def vote_multiple(votes,object)
    count = 0
    
		votes.each do |vote|
      if vote.article_comment.article == object.article_comment.article
		    count = count + 1
		  end
	  end
	  count
  end
end

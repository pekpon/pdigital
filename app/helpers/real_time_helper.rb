module RealTimeHelper
  def vote_multiple(votes,object)
    count = 0
    
		votes.each do |vote|
		  if vote.comment.nil?
	    else
        if vote.comment.commentable == object.comment.commentable
		      count = count + 1
		    end
	    end
	  end
	  count
  end
end

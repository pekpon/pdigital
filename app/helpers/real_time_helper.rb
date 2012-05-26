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
  
  def getPath(object)
    if object.class.to_s == 'Article' or object.class.to_s == 'Debate' or object.class.to_s == 'Event'
      type = object.class.to_s
      obj = object
    elsif object.class.to_s == 'Comment'
      type = object.commentable.class.to_s
      obj = object.commentable
    else
      type = object.comment.commentable.class.to_s
      obj = object.comment.commentable
    end

    path = article_path(obj)  if type == 'Article'
    path = debate_path(obj)  if type == 'Debate'
    path = event_path(obj)  if type == 'Event'
    
    return path
  end
  
  def getText(object,var)
    if object.class.to_s == 'Article' or object.class.to_s == 'Debate' or object.class.to_s == 'Event'
      type = object.class.to_s
      t = "new_"
      obj = object
    elsif object.class.to_s == 'Comment'
      type = object.commentable.class.to_s
      obj = object.commentable
      t = "comment_"
    else
      type = object.comment.commentable.class.to_s
      obj = object.comment.commentable
      t = "vote_"
    end
    
    t = t + "new" if type == 'Article'
    t = t + "deb" if type == 'Debate'
    t = t + "eve" if type == 'Event'
    
    newText = t(t, :var => var) if type == 'Article'
    newText = t(t, :var => var) if type == 'Debate'
    newText = t(t, :var => var) if type == 'Event'
    
    return newText
  end
  
  def getLink(title)
    
    if title.length > 50
      title.slice(0,50)+"..."
    else
      title
    end    
  end
  
  def isNew(object)
    if object.class.to_s == 'Article' or object.class.to_s == 'Debate' or object.class.to_s == 'Event'
      true
    end
  end
  
  def isComment(object)
    if object.class.to_s == 'Comment'
      true
    end
  end
  
end





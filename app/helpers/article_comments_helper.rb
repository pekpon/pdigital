module ArticleCommentsHelper

    def vote_status(comment)
      if comment > 0
        return "positive"
      end
      if comment < 0
        return "negative"
      end
      if comment == 0
        return "neutral"
      end
    end
    
    def delete_actions(comment)
      if current_user.present? and comment.user.present? and comment.created_at+15.minutes > Time.now
        if current_user.username == comment.user.username
          "onmouseover='javascript:show_delete_comment(#{comment.id})' onmouseout='javascript:hide_delete_comment(#{comment.id})'"
        end
      end
    end

end

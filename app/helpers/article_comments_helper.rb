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

end

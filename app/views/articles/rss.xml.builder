xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Configuration.value(:title_site)
    xml.description Configuration.value(:description_site)
    xml.link request.protocol+request.host+"/rss.xml"
    # xml.image do
    #       xml.url 
    #       xml.title
    #       xml.link
    #     end
    
    for article in @articles
      xml.item do
        xml.title article.title
        xml.description article.body
        # xml.image do
        #           xml.url 
        #           xml.title
        #           xml.link 
        #         end
        xml.pubDate article.published_date.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end
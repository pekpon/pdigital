xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Configuration.value(:title_site)
    xml.description Configuration.value(:description_site)
    xml.link request.env['HTTP_HOST']+"/rss.xml"
    xml.image do
      xml.url "http://www.ceataller.com.ar/webroot/img/ico-news-big.png"
      xml.title Configuration.value(:title_site)
      xml.link request.env['HTTP_HOST']+"/rss.xml"
    end
    
    for article in @articles
      xml.item do
        xml.title article.title
        xml.description article.body
        xml.image do
          xml.url request.env['HTTP_HOST']+article.images.first.image.url(:detail) if article.images.first
          xml.title article.title
          xml.link request.env['HTTP_HOST']+article.images.first.image.url(:detail) if article.images.first
        end
        xml.pubDate article.published_date.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end
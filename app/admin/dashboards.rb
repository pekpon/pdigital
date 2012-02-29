ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end

  section "Last Articles" do
    ul do
      articles = Article.limit(5)
      unless articles.empty?
        articles.collect do |art|
          li link_to(art.title, admin_article_path(art))
        end
      else
        li "No Articles in the DB"
      end
    end
  end

  section "Last Polls" do
    ul do
      polls = Article.limit(5)
      unless polls.empty?
        articles.collect do |poll|
          li link_to(poll.title, admin_poll_path(poll))
        end
      else
        li "No Polls in the DB"
      end
    end

  end

  section "tools" do
    ul do
      li link_to(t(:create_article), new_admin_article_path)
    end
  end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end

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
  #
  # section "Last Polls" do
  #     ul do
  #       polls = Poll.limit(5)
  #       unless polls.empty?
  #         polls.collect do |poll|
  #          # li link_to(poll.title, admin_poll_path(poll))
  #         end
  #       else
  #         li "No Polls in the DB"
  #       end
  #     end
  # 
  #   end
  # 
  #   section "tools" do
  #     ul do
  #       li link_to(t(:create_article), new_admin_article_path)
  #     end
  #   end
  
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
  
  section "Statistics Last 24h", :priority => 1 do
    div :class => "content" do
      div :class => "box" do
        articles = Article.find(:all, :conditions => { :published => true, :created_at => (Time.now-24.hours)..(Time.now) }).count
        raw(articles.to_s + "<div class = 'text'>Articles</div>")
      end
      
      div :class => "box" do
        comments = Comment.find(:all, :conditions => { :active => true, :created_at => (Time.now-24.hours)..(Time.now) }).count
        raw(comments.to_s + "<div class = 'text'>Comments</div>")
      end  
      
      div :class => "box" do
        events = Event.find(:all, :conditions => { :active => true, :created_at => (Time.now-24.hours)..(Time.now) }).count
        raw(events.to_s + "<div class = 'text'>Events</div>")
      end  
        
      div :class => "box last" do
        debates = Debate.find(:all, :conditions => { :active => true, :created_at => (Time.now-24.hours)..(Time.now) }).count
        raw(debates.to_s + "<div class = 'text'>Debates</div>")
      end
    end
  end
  
  section "Last Comments" do
    ul do
      comments = Comment.limit(5).order("id DESC").where(:active => true)
      unless comments.empty?
        comments.collect do |com|
          if com.commentable.class.to_s == "Article"
            li raw("<span class='tag tarticle'>ARTICLE</span>") + link_to(com.body.slice(0,30)+"...", admin_comentari_path(com))
          elsif com.commentable.class.to_s == "Debate"
            li raw("<span class='tag tdebate'>DEBATE</span>") + link_to(com.body.slice(0,30)+"...", admin_comentari_path(com))
          else
            li raw("<span class='tag tevent'>EVENT</span>") + link_to(com.body.slice(0,30)+"...", admin_comentari_path(com))
          end
        end
      else
        li "No Comments in the DB"
      end
    end
  end
  
  section "Last Events" do
    ul do
      events = Event.limit(5).order("id DESC")
      unless events.empty?
        events.collect do |eve|
          if eve.active == true
            li raw("<span class='tag tactive'>ACTIVE</span>") + link_to(eve.title.slice(0,30)+"...", admin_event_path(eve))
          else
            li raw("<span class='tag tinactive'>INACTIVE</span>") + link_to(eve.title.slice(0,30)+"...", admin_event_path(eve))
          end
        end
      else
        li "No Events in the DB"
      end
    end
  end

end

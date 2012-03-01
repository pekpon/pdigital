require "bundler/capistrano"


set :application, "pdigital"

# Set IP addr on the console line like
# cap -s domain=IP
#set :domain, 'IP ADDR'

# Repository
set :scm, :git
set :keep_releases, 3
set :branch, 'master'
set :repository,  "https://github.com/argami/pdigital.git"

#deployment details
set :use_sudo, false
set :user, 'cloud'
set :deploy_to, "/home/#{user}/#{application}"

#PATH to rbenv
set :default_environment, {
  'PATH' => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH"
}


ssh_options[:forward_agent] = true

role :web, domain
role :app, domain
role :db, domain, :primary => true

namespace :deploy do
  task :start do
    run "cd #{deploy_to}/current && RAILS_ENV=production bundle exec thin -e production -d start"
  end

  task :stop do
    run "cd #{deploy_to}/current && RAILS_ENV=production bundle exec thin -e production -d -O stop"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{deploy_to}/current && RAILS_ENV=production bundle exec thin -e production -d -O -w120 restart"
  end

  namespace :db do

    desc <<-DESC
        Creates the database.yml configuration file in shared path.

        By default, this task uses a template unless a template \
        called database.yml.erb is found either is :template_dir \
        or /config/deploy folders. The default template matches \
        the template for config/database.yml file shipped with Rails.

        When this recipe is loaded, db:setup is automatically configured \
        to be invoked after deploy:setup. You can skip this task setting \
        the variable :skip_db_setup to true. This is especially useful \ 
        if you are using this recipe in combination with \
        capistrano-ext/multistaging to avoid multiple db:setup calls \ 
        when running deploy:setup for all stages one by one.
    DESC
    task :setup, :except => { :no_release => true } do

      default_template = <<-EOF
        base: &base
          adapter: sqlite3
          timeout: 5000
        development:
          database: #{shared_path}/db/development.sqlite3
          <<: *base
        test:
          database: #{shared_path}/db/test.sqlite3
          <<: *base
        production:
          database: #{shared_path}/db/production.sqlite3
          <<: *base
      EOF

      location = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
      template = File.file?(location) ? File.read(location) : default_template

      config = ERB.new(template)

      run "mkdir -p #{shared_path}/db" 
      run "mkdir -p #{shared_path}/config" 
      put config.result(binding), "#{shared_path}/config/database.yml"
    end

    desc <<-DESC
        [internal] Updates the symlink for database.yml file to the just deployed release.
    DESC
    task :symlink, :except => { :no_release => true } do
      run "rm #{release_path}/config/database.yml"
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
    end

  end

  after "deploy:setup",           "deploy:db:setup"   unless fetch(:skip_db_setup, false)
  after "deploy:finalize_update", "deploy:db:symlink"

end



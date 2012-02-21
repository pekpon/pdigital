Welcome to pdigital
==

PDigital is a NewsPaper platform built on ruby on rails


Deploy to development


Deploy to production
--

In the mean time we are not capistrano based deploy the steps for deploying:

1. Set the enviroment variable in .bashrc

	`export RAILS_ENV=production`

2. Clone the code in the server
	
	`git clone https://github.com/pekpon/pdigital.git`

3. Install all the gems using bundler

	`bundle install`

4. Set database
	
	Change your `config/database.yml` to set your needs 

5. Run the db setup

	`rake db:setup`

4. This is prepared to being used with assets pipelines so we need to precomplile the assets

	`rake assets:precomplile`
	
5. We're using thin as server:

	`bundle exec thin -s 3 -R config.ru -e production -d start`
	
	This sets 3 thin server on 3000, 3001, 3002.  
	The -e param is optional if you already set up your ENV
	
	**To Restart**  
	To restart the severs one by one to non stop the system just need to 
	
	`bundle exec thin -s 3 -R config.ru -e production -d -w120 -O restart`
# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([
  { name: 'Sports'},
  { name: 'Opinion'},
  { name: 'Economy'},
  { name: 'Education'},
  { name: 'Entities'},
  { name: 'Media'},
  { name: 'Services'},
  { name: 'Culture'},
  { name: 'County'},
  { name: 'Policy'},
  { name: 'Society'}
])


Configuration.find_or_create_by_key(:key => 'head_image_left', :values => 'http://placehold.it/500x100')
Configuration.find_or_create_by_key(:key => 'head_image_right', :values => 'http://placehold.it/400x64')

Configuration.create([
  {:key => 'title_site', :values => 'pDigital - Your news'},
  {:key => 'description_site', :values => 'pDigital is a online newspaper used in towns and cities'},
  {:key => 'image_site', :values => 'http://placehold.it/100x100'},
  {:key => 'sitename', :values => 'pDigital'},
  {:key => 'domain', :values => 'http://URL_WEB'},
  
  {:key => 'like_sentence', :values => 'Thanks for visiting!'},
  {:key => 'facebook_like_button', :values => 'www.google.com'},
  {:key => 'facebook_web', :values => 'Facebook Website'},
  {:key => 'foot_description', :values => 'is a newspaper....'},
  {:key => 'youtube_channel', :values => 'Youtube Channel'},
  {:key => 'twitter_web', :values => 'Twitter Website'},

  {:key => 'analytics_tracking', :values => "UU-00000-AA"},
  
  {:key => 'link1', :values => "<li class='portada'><a href='http://www.WEB_DE_DESTINO.com' target='_blank'>NOMBRE_A_MSTRAR</a></li>"},
  {:key => 'link2', :values => "<li class='portada'><a href='http://www.WEB_DE_DESTINO.com' target='_blank'>NOMBRE_A_MSTRAR</a></li>"},
  
  {:key => 'openx_header', :values => 'OpenX Header'},
  
  {:key => 'openx_home_zone_a', :values => '[ZONE]'},
  {:key => 'openx_home_code_a', :values => '[CODE]'},
  
  {:key => 'openx_home_zone_b', :values => '[ZONE]'},
  {:key => 'openx_home_code_b', :values => '[CODE]'},
  
  {:key => 'openx_home_zone_c', :values => '[ZONE]'},
  {:key => 'openx_home_code_c', :values => '[CODE]'},
  
  {:key => 'openx_inner_zone_a', :values => '[ZONE]'},
  {:key => 'openx_inner_code_a', :values => '[CODE]'},
  
  {:key => 'openx_inner_zone_b', :values => '[ZONE]'},
  {:key => 'openx_inner_code_b', :values => '[CODE]'},
  
  {:key => 'openx_inner_zone_c', :values => '[ZONE]'},
  {:key => 'openx_inner_code_c', :values => '[CODE]'},
  
  {:key => 'openx_pos_home_a', :values => '1'},
  {:key => 'openx_pos_home_b', :values => '2'},
  {:key => 'openx_pos_home_c', :values => '1'},
  
  {:key => 'facebook_plugin_pos', :values => '3'},
  {:key => 'facebook_plugin_code', :values => '<div class="fb-like-box" data-href="http://www.URL_WEBSITE.com" data-width="300" data-height="360" data-show-faces="true" data-border-color="white" data-stream="false" data-header="true"></div>
  '},
  
  {:key => 'twitter_plugin_pos', :values => '1'},
  
  {:key => 'sports_id', :values => '1'},
  {:key => 'opinion_id', :values => '2'},
  
  {:key => 'real_time_votes', :values => '20'},
  ])

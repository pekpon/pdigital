# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([
  { name: 'Esports'},
  { name: 'Opinió'},
  { name: 'Economia'},
  { name: 'Educació'},
  { name: 'Entitats'},
  { name: 'Mitjans'},
  { name: 'Serveis'},
  { name: 'Cultura'},
  { name: 'Comarca'},
  { name: 'Política'},
  { name: 'Societat'}
])


Configuration.find_or_create_by_key(:key => 'head_image_left', :values => 'http://placehold.it/500x100')
Configuration.find_or_create_by_key(:key => 'head_image_right', :values => 'http://placehold.it/400x64')

Configuration.create([
  {:key => 'title_site', :values => 'pDigital - Your news'},
  {:key => 'description_site', :values => 'pDigital is a online newspaper used in towns and cities'},
  {:key => 'image_site', :values => 'http://placehold.it/100x100'},
  {:key => 'sitename', :values => 'pDigital'},

  {:key => 'analytics_tracking', :values => "UU-00000-AA"},
  
  {:key => 'link1', :values => "<li class='portada'><a href='http://www.WEB_DE_DESTINO.com' target='_blank'>NOMBRE_A_MSTRAR</a></li>"},
  {:key => 'link2', :values => "<li class='portada'><a href='http://www.WEB_DE_DESTINO.com' target='_blank'>NOMBRE_A_MSTRAR</a></li>"},
  
  {:key => 'openx_header', :values => ''},
  
  {:key => 'openx_home_zone_a', :values => ''},
  {:key => 'openx_home_code_a', :values => ''},
  
  {:key => 'openx_home_zone_b', :values => ''},
  {:key => 'openx_home_code_b', :values => ''},
  
  {:key => 'openx_home_zone_c', :values => ''},
  {:key => 'openx_home_code_c', :values => ''},
  
  {:key => 'openx_article_zone_a', :values => ''},
  {:key => 'openx_article_code_a', :values => ''},
  
  {:key => 'openx_article_zone_b', :values => ''},
  {:key => 'openx_article_code_b', :values => ''},
  
  {:key => 'openx_pos_home_a', :values => '1'},
  {:key => 'openx_pos_home_b', :values => '2'},
  {:key => 'openx_pos_home_c', :values => '1'},

  {:key => 'sports_id', :values => '1'},
  {:key => 'opinion_id', :values => '2'}
  ])

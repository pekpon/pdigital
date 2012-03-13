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
  { name: 'Politic'},
  { name: 'Society'}
])

Configuration.create([
  {:key => 'title_site', :values => 'pDigital - Your news'},
  {:key => 'description_site', :values => 'pDigital is a online newspaper used in towns and cities'},
  {:key => 'image_site', :values => 'http://placehold.it/100x100'},
  {:key => 'sitename', :values => 'pDigital'},

  {:key => 'analitycs_tracking', :values => ''},
  {:key => 'link1', :values => ''},
  {:key => 'link2', :values => ''},

  {:key => 'sports_id', :values => '1'},
  {:key => 'opinion_id', :values => '2'}
  ])
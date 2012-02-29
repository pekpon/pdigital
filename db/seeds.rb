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
  {:key => 'head_image_left', :values => 'http://placehold.it/500x100'},
  {:key => 'head_image_right', :values => 'http://placehold.it/400x64'}
])

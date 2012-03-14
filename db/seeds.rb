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


Configuration.find_or_create_by_key(:key => 'head_image_left', :values => 'http://placehold.it/500x100')
Configuration.find_or_create_by_key(:key => 'head_image_right', :values => 'http://placehold.it/400x64')



Configuration.create([
  {:key => 'title_site', :values => 'pDigital - Your news'},
  {:key => 'description_site', :values => 'pDigital is a online newspaper used in towns and cities'},
  {:key => 'image_site', :values => 'http://placehold.it/100x100'},
  {:key => 'sitename', :values => 'pDigital'},

  {:key => 'analytics_tracking', :values => "<script type='text/javascript'>

    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'PASTE YOUR ANALYTICS CODE HERE']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();

  </script>"},
  {:key => 'link1', :values => 'test_link'},
  {:key => 'link2', :values => 'test_link'},

  {:key => 'sports_id', :values => '1'},
  {:key => 'opinion_id', :values => '2'}
  ])

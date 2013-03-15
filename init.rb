require 'redmine'

require_dependency 'favorite_locations/view_hook_listener'
require_dependency File.expand_path(File.join(File.dirname(__FILE__), 'app/controllers/favorite_locations_controller'))

Redmine::Plugin.register :favorite_locations do
  name 'Favorite Locations plugin'
  author 'Luke Gruber'
  description 'Easily navigate to your favorite places per project via the home page'
  version '0.0.1'
  url ''
  author_url ''

  permission :favorite_locations, { :favorite_locations => [:index, :create, :update, :edit, :destroy] }, :public => true
end

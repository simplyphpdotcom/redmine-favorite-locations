Redmine plugin: Favorite Locations
==================================

Favorite Locations allows a user to add quick links to their favorite
(read: most-accessed) redmine pages on their home page. It will save you
valuable seconds that could otherwise have been spent travelling, wine-tasting
or flying your helicopter.

Installation
------------

Clone latest version of plugin from git, install it to plugins. From redmine
APP ROOT:

1. If inside a git project already:

        $ git submodule add git@github.com:mentel/redmine-favorite-locations.git plugins/favorite_locations

        $ git commit -m "add plugin 'favorite_locations' as submodule"

   Otherwise:

        $ git clone git@github.com:mentel/redmine-favorite-locations.git plugins/favorite_locations

2. Make sure your plugin folder name is favorite\_locations

3. Run the plugin migrations:

        $ bundle exec rake db:migrate_plugins:favorite_locations

4. symlink or copy assets/javascripts/favorite\_locations/application.js to
   redmine's public/javascripts/favorite\_locations.js

5. Restart your Redmine web server

Plugin **should** work now.

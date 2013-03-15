Redmine plugin: Favorite Locations
==================================

Favorite Locations allows a redmine admin to configure their homescreen with
various links to project pages. This saves time!

Installation
------------

Clone latest version of plugin from git, install it to plugins. From redmine
APP ROOT:

If inside a git project already:

1. $ git submodule add git@github.com/mentel/redmine-favorite-locations.git plugins/favorite\_locations
   $ git commit -m "add plugin 'favorite\_locations's as submodule" 

Otherwise:

   $ git clone git@github.com/mentel/favorite\_locations.git plugins/favorite\_locations

2. Make sure your plugin folder name is favorite\_locations

3. Run the plugin migrations:
$ bundle exec rake db:migrate\_plugins:favorite\_locations

4. symlink or copy assets/javascripts/favorite\_locations/application.js to
   redmine's public/javascripts folder

5. Restart your Redmine web server

Plugin **should** work now.

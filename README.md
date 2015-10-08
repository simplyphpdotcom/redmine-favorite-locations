Redmine plugin: Favorite Locations
==================================

Favorite Locations allows a user to add quick links to their favorite
(read: most-accessed) redmine pages right on their home page.

All of these links will be saved per user and shown on the home page,
project overview pages, project issue pages and project wiki pages. We find
these are our most-viewed pages, so the quick links here are the most valuable
for us. If you want to hook into other pages send us a Github issue.

Features/Caveats
================

This plugin works best with the Unicorn web server. This is because
after a link's been created it scrapes that page for the title and
displays that as the text for the link. Scraping one's own site causes
problems in threaded server environments, so as a workaround the scraping is
performed 3 seconds after the creation of the link. As a result, when using
a non-Unicorn server, any link text changes will only be seen after a refresh.

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

3. bundle install

4. Run the plugin migrations:

        $ bundle exec rake redmine:plugins:migrate NAME=favorite_locations RAILS_ENV=production

Plugin **should** work now.

Screenshots
-----------

![Favorite Locations in welcome page](http://i.imgur.com/lgcYTAo.jpg)

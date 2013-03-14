class FavoriteLocationsViewHookListener < Redmine::Hook::ViewListener 
  require_dependency File.join(Rails.root, 'plugins/favorite_locations/app/models/favorite_location')

  def view_welcome_index_right(context = {})
    output_favorite_locations(load_favorite_locations).html_safe
  end

  def output_favorite_locations(locations)
    html = %{<div class="box favorite-locations-box" id="favorite-locations-box">}
    html << "<h3>Favorite Locations</h3>"
    locations.group_by { |l| l.project.name }.each do |proj_name, locs|
      html << %{<p class="favorite-location-project-name-header" style="font-variant: small-caps; font-size: 16px;">#{proj_name}</p>}
      if locs.any?
        html << "<ul>"
      end
      locs.each do |loc|
        html << "<li>"
        html << link_to(loc.link_text, send(FavoriteLocation::PROJECT_LOCATIONS[loc.link_location], loc.project))
        html << "</li>"
      end
      if locs.any?
        html << "</ul>"
      end
    end
    html
  end

  def load_favorite_locations
    fav_locations = FavoriteLocation.for_user(User.current)
  end 

end 

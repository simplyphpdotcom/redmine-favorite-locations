class FavoriteLocationsViewHookListener < Redmine::Hook::ViewListener 
  require_dependency File.join(Rails.root, 'plugins/favorite_locations/app/models/favorite_location')

  def view_welcome_index_right(context = {})
    output_js_bootstrap
  end

  def output_js_bootstrap
    html = <<-HTML.html_safe
    #{javascript_include_tag('favorite_locations.js')}
    <div class="box favorite-locations-box" id="favorite-locations-box">
      <h3>Favorite Locations</h3>
      <div class="favorite-location-list"></div>
      <div class="favorite-location-create">
        #{link_to('New Location', {
          :controller => 'favorite_locations',
          :action => :new
          },
          :remote => true,
          :'data-target' => '.favorite-location-list')}
      </div>
    </div>
    HTML
  end

end 

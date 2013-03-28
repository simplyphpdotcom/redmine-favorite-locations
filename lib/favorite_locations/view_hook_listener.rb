class FavoriteLocationsViewHookListener < Redmine::Hook::ViewListener 
  require_dependency File.join(Rails.root, 'plugins/favorite_locations/app/models/favorite_location')

  def view_welcome_index_right(context = {})
    favorite_locations_index_form
  end

  def view_layouts_base_html_head(context = {})
    stylesheet_link_tag 'favorite_locations', :media => 'screen'
  end

  def view_layouts_base_sidebar(context = {})
    return unless context[:controller]
    if context[:controller].class.name == 'WikiController'
      favorite_locations_index
    end
  end

  def view_issues_sidebar_issues_bottom(context = {})
    favorite_locations_index
  end

  def view_projects_show_sidebar_bottom(context = {})
    favorite_locations_index
  end

  private

  def favorite_locations_index_form
    return '' if User.current.anonymous?
    html = <<-HTML.html_safe
    #{javascript_include_tag('favorite_locations.js')}
    <div class="box favorite-locations-box" id="favorite-locations-box">
      <h3>Favorite Locations</h3>
      <div class="favorite-location-list"></div>
      <div class="favorite-location-create" style="margin-top: 20px;">
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

  def favorite_locations_index
    return '' if User.current.anonymous?
    html = <<-HTML.html_safe
    #{no_edit_favorite_locations_js}
    #{javascript_include_tag('favorite_locations.js')}
    <div class="box favorite-locations-box" id="favorite-locations-box">
      <h3>Favorite Locations</h3>
      <div class="favorite-location-list"></div>
    </div>
    HTML
  end

  def no_edit_favorite_locations_js
    js = <<-JS
    <script>
      favoriteLocationsNoEdit = true;
    </script>
    JS
  end
end 

class FavoriteLocationsViewHookListener < Redmine::Hook::ViewListener 
  require_dependency File.join(Rails.root, 'plugins/favorite_locations/app/models/favorite_location')

  def view_welcome_index_right(context = {})
    favorite_locations_index_form context
  end

  def view_layouts_base_html_head(context = {})
    stylesheet_link_tag 'application', :plugin => 'favorite_locations'
  end

  def view_layouts_base_sidebar(context = {})
    return unless context[:controller]
    if context[:controller].class.name == 'WikiController'
      favorite_locations_index context
    end
  end

  def view_issues_sidebar_issues_bottom(context = {})
    favorite_locations_index context
  end

  def view_projects_show_sidebar_bottom(context = {})
    favorite_locations_index context
  end

  private

  def root_url(context)
    url_for controller: 'welcome'
  end

  def favorite_locations_index_form(context)
    return '' if User.current.anonymous?
    html = <<-HTML.html_safe
    <script type="text/javascript">
      var BASE_URL = '#{ root_url(context) }';
    </script>
    #{javascript_include_tag 'application', :plugin => 'favorite_locations'}
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

  def favorite_locations_index(context)
    return '' if User.current.anonymous?
    html = <<-HTML.html_safe
    #{no_edit_favorite_locations_js}
    <script type="text/javascript">
      var BASE_URL = '#{ root_url(context) }';
    </script>
    #{javascript_include_tag 'application', :plugin => 'favorite_locations'}
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

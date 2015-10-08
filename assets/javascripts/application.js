$(function() {

  var ajaxHandler = function(evt, data, status, xhr) {
    var $clicked = $(this),
        $submit = $clicked.find('input[type=submit]'),
        $target, insertionMethod;
    if ($submit.length) $clicked = $submit;
    $target = $( $clicked.data("target") );
    if (!$target) return false;
    insertionMethod = $clicked.data("insertion") || 'append';
    $target[insertionMethod](data.html);
    if ( $(evt.currentTarget).hasClass('new_favorite_location') ) {
      $('#favorite_location_link_path').val('');
      $('#favorite_location_page_title').val('');
    }
  }

 $('#favorite-locations-box').on("ajax:success", "a[data-remote]", ajaxHandler);
 $('#favorite-locations-box').on("ajax:success", "form", ajaxHandler);

  // pre-populate the favorite locations from index action
  $.ajax({
    url: BASE_URL + 'favorite_locations',
    dataType: 'json',
    data: {
      no_edit_favorite_locations: window.favoriteLocationsNoEdit
    },
    success: function(data, textStatus, xhr) {
      var html = data.html;
      $(html).appendTo('.favorite-location-list');
    },
    error: function(data, textStatus, xhr) {
      console.log('favorite locations index ajax error');
    }
  });

  $('.favorite-location-create').click(function(e) {
    if ($('#favorite_location_link_path').length) {
      return false;
    }
  });

  $('#favorite-locations-box').on('click', '#new_favorite_location input[type=submit]', function(e) {
    var $target = $(e.currentTarget),
        linkPathValue = $target.siblings('#favorite_location_link_path').val();
    if (!linkPathValue) return false;
  });

});

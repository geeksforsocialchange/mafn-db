$(function(){

  $(".js-member-locations a.add_fields").
    data("association-insertion-position", 'before').
    data("association-insertion-node", 'this');

  $('.js-member-locations').bind('cocoon:after-insert',
    function(e, loc) {
      console.log("inserting new location...");
      $(".js-member-location-fields a.add_fields").
        data("association-insertion-position", 'before').
        data("association-insertion-node", 'this');

      $(this).find('.js-member-location-fields').bind('cocoon:after-insert',
        function() {
          console.log("insert new location...");
          $(this).children(".js-location-from-list").remove();
          $(this).children("a.add_fields").hide();
        });
      });


  if($(".js-form__needs-entity").length > 0) {
    // If this div exists, hide the form until something is selected
    $(".form").hide();
    // When somene's picked something...
    $(".js-form__entity-selector").change(function(){
      // ... show the form ...
      $(".form").show();
      // ... get the value from the picker ...
      var entity_id = $(".js-form__entity-selector").val();
      // ... and append it to the form method as a GET variable
      $('form').attr('action', function(i, value) {
          return value + "&subject=" + entity_id;
      });
    })
  }
});

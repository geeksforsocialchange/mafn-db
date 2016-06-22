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
});

$(function(){
  $("#js-member-addresses a.add_fields").
    data("association-insertion-position", 'before').
    data("association-insertion-node", 'this');

  $('#js-member-addresses').on('cocoon:after-insert',
    function() {
      console.log("content inserted");
      $(".js-member-location-fields a.add_fields").
        data("association-insertion-position", 'before').
        data("association-insertion-node", 'this');
      $('.js-member-location-fields').on('cocoon:after-insert',
        function() {
          console.log("location removed");
          $(this).children("#js-location-from-list").remove();
          $(this).children("a.add_fields").hide();
        });
      });
});

$(function(){
  // Setup - add a text input to each footer cell
  $('.js-table-sort tfoot th.js-table-sort__searchable').each( function () {
      var title = $(this).text();
      $(this).html( '<input type="text" size="10" placeholder="Search '+title+'" />' );
  } );

	var table = $('.js-table-sort').DataTable({
    pageLength: 25,
  });

  // Apply the search
  table.columns().every( function () {
      var that = this;
      $( 'input', this.footer() ).on( 'keyup change', function () {
          if ( that.search() !== this.value ) {
              that
                .search( this.value )
                .draw();
          }
      } );
  } );
});

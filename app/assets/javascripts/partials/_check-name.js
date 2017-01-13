$(function() {
    // When the data-duplicate element loses focus, search for duplicate members
    $('[data-duplicate]').blur(function() {
        $this = $(this);
        $.get($this.data('duplicate'), {
            last_name: $this.val()
        }).success(function(matches) {
            $('.js-duplicate-names').empty();
            $('.js-duplicate-names').append(matches);
        }).error(function() {
            $('.js-duplicate-names').empty();
        });
    });
});

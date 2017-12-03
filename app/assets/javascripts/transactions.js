$(document).ready(
  function () {
    _.each($('.transaction-details-btn'), function(btn) {
      $(btn).on('click', function(e) {
        var path = $(e.target).closest('button').attr('data-path');

        $.get(path, function(response) {
          $('.transaction-container').html(response);
          $('.transaction-container .modal').modal('show');
        })
      });
    });
  }
);

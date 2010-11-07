function mark_for_destroy(element) {
  $(element).next('.should_destroy').value = 1;
  $(element).up('.card').hide();
}

function revealBack(request_path) {
  new Ajax.Request(request_path, {
    method: 'GET',
    onSuccess: function(response) {
      $('card_back').update(response.responseText);
    }
  });
}

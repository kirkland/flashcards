function mark_for_destroy(element) {
  $(element).next('.should_destroy').value = 1;
  $(element).up('.card').hide();
}

function revealBack(request_path) {
  new Ajax.Request(request_path, {
    method: 'GET',
    onSuccess: function(response) {
      $('card_back_value').update(response.responseText);
    }
  });
}

function nextCard(request_path) {
  new Ajax.Request(request_path, {
    method: 'POST',
    onSuccess: function(response) {
      $('card_front_value').update(response.responseText);
      $('card_back_value').update("");
    }
  });
}

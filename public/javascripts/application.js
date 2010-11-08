function mark_for_destroy(element) {
  $(element).next('.should_destroy').value = 1;
  $(element).up('.card').hide();
}

function revealBack(request_path) {
  new Ajax.Request(request_path, {
    method: 'GET',
    onSuccess: function(response) {
      $('card_back_value').update(response.responseText);
      $('reveal_back_link').hide();
    }
  });
}

function nextCard(request_path) {
  new Ajax.Request(request_path, {
    method: 'POST',
    onSuccess: function(response) {
      var text = response.responseText;
      if(text == "no more cards") {
        $('game_nav').update("Game Over");
      } else {
        $('card_front_value').update(text);
        $('card_back_value').update("");
        $('reveal_back_link').show();
      }
    }
  });
}

function makeNextLink(link) {
  $("card_front").observe('click', function() {revealBack(link)});
}

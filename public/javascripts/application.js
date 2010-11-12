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
      $('card_back').addClassName("solid-border").removeClassName("dashed-border");
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
        $('card_back').addClassName("dashed-border").removeClassName("solid-border");
      }
    }
  });
}

function setupQuiz(options) {
  $("card_front").observe('click', function() {revealBack(options.back_path)});
  $("card_back").observe('click', function() {nextCard(options.next_path)});
}

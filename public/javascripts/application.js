function mark_for_destroy(element) {
  $(element).next('.should_destroy').value = 1;
  $(element).up('.card').hide();
}

function reveal_back(request_path) {
  new Ajax.Request(request_path, {
    method: 'GET',
    onSuccess: function(response) {
      $('card_back_value').update(response.responseText);
      $('reveal_back_link').hide();
      $('card_back').addClassName("solid-border").removeClassName("dashed-border");
    }
  });
}

function next_card(request_path) {
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

// move the game along, either revealing the back or going to next card
function game_next() {
  if ($('card_back').hasClassName("dashed-border")) {
    reveal_back();
  } else {
    next_card();
  }
}

function setupQuiz(options) {
  $("card_front").observe('click', function() {reveal_back(options.back_path)});
  $("card_back").observe('click', function() {next_card(options.next_path)});
  next_card(options.next_path);
}

function adjust_font(amount) {
  start_size = parseInt($("card_front_value").getStyle('font-size'));
  $("card_front_value").setStyle({fontSize: "" + (start_size + amount) + "px"});
  $("card_back_value").setStyle({fontSize: "" + (start_size + amount) + "px"});
}


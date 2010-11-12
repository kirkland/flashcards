Quiz = Class.create({
  initialize: function(options) {
    this.back_path = options.back_path;
    this.next_path = options.next_path;

    $("card_front").observe('click', this.reveal_back.bindAsEventListener(this));
    $("card_back").observe('click', this.next_card.bindAsEventListener(this));
    this.next_card();
  },

  reveal_back: function() {
    new Ajax.Request(this.back_path, {
      method: 'GET',
      onSuccess: function(response) {
        $('card_back_value').update(response.responseText);
        $('reveal_back_link').hide();
        $('card_back').addClassName("solid-border").removeClassName("dashed-border");
      }
    });
  },

  next_card: function() {
    new Ajax.Request(this.next_path, {
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
});

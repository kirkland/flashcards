Quiz = Class.create({
  initialize: function(options) {
    this.back_path = options.back_path;
    this.next_path = options.next_path;

    $("card_front").observe('click', this.reveal_back.bindAsEventListener(this));
    $("card_back").observe('click', this.next_card.bindAsEventListener(this));
    this.next_card();
  },

  reveal_back: function() {
    console.log("show back");
    new Ajax.Request(this.back_path, {
      method: 'GET',
      onSuccess: function(response) {
        $('card_back_value').update(response.responseText);
        $('card_back').addClassName("solid-border").removeClassName("dashed-border");
      }
    });
  },

  next_card: function() {
    console.log("next");
    new Ajax.Request(this.next_path, {
      method: 'POST',
      onSuccess: function(response) {
        var text = response.responseText;
        if(text == "no more cards") {
          console.log("game over");
          $('notice').update("Game Over");
        } else {
          console.log("good");
          $('card_front_value').update(text);
          $('card_back_value').update("");
          $('card_back').addClassName("dashed-border").removeClassName("solid-border");
        }
      }
    });
  }
});

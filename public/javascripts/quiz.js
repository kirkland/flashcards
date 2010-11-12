Quiz = Class.create({
  initialize: function(options) {
    this.back_path = options.back_path;
    this.next_path = options.next_path;
    this.card_status = "hidden";

    $("card_front").observe('click', this.quiz_next.bindAsEventListener(this));
    $("card_back").observe('click', this.quiz_next.bindAsEventListener(this));
    this.next_card();
  },

  reveal_back: function() {
    new Ajax.Request(this.back_path, {
      method: 'GET',
      onSuccess: function(response) {
        this.card_status = "revealed";
        $('card_back_value').update(response.responseText);
        $('card_back').addClassName("solid-border").removeClassName("dashed-border");
      }.bind(this)
    });
  },

  next_card: function() {
    new Ajax.Request(this.next_path, {
      method: 'POST',
      onSuccess: function(response) {
        var text = response.responseText;
        if(text == "no more cards") {
          $('notice').update("Game Over");
        } else {
          this.card_status = "hidden";
          $('card_front_value').update(text);
          $('card_back_value').update("");
          $('card_back').addClassName("dashed-border").removeClassName("solid-border");
        }
      }.bind(this)
    });
  },

  quiz_next: function() {
    if (this.card_status == "revealed") {
      this.next_card();
    } else {
      this.reveal_back();
    }
  }
});

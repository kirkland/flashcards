Quiz = Class.create({
  initialize: function(options) {
    this.back_path = options.back_path;
    this.next_path = options.next_path;
    this.card_status = "hidden";

    this.next_card();
  },

  next_card: function(answer_result) {
    new Ajax.Request(this.next_path, {
      method: 'POST',
      parameters: {correct: answer_result},
      onSuccess: function(response) {
        var text = response.responseText;
        if(text == "no more cards") {
          this.end_game();
        } else {
          this.card_status = "hidden";
          $('card_front_value').update(text);
          $('card_back_value').update("");
          $('card_back').addClassName("dashed-border").removeClassName("solid-border");
        }
      }.bind(this)
    });
  },

  reveal_back: function() {
    new Ajax.Request(this.back_path, {
      method: 'GET',
      onSuccess: function(response) {
        this.card_status = "revealed";
        $('card_back_value').update(response.responseText);
        $('card_back').addClassName("solid-border").removeClassName("dashed-border");
        $('correct_links_area').show();
        $('reveal_card_link').hide();
      }.bind(this)
    });
  },

  quiz_next: function() {
    if (this.card_status == "revealed") {
      this.next_card();
    } else {
      this.reveal_back();
    }
  },

  end_game: function() {
    $('quiz_nav').hide();
    $('site_nav').show();
  },

  answered_correctly: function() {
    $('reveal_card_link').show();
    $('correct_links_area').hide();
    this.next_card("correct");
  },

  answered_wrong: function() {
    $('reveal_card_link').show();
    $('correct_links_area').hide();
    this.next_card("incorrect");
  }
});

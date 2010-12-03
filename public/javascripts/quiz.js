Quiz = Class.create({
  initialize: function(options) {
    this.card_path = options.card_path;

    $('flip_link').observe('click', this.flip_card.bindAsEventListener(this));
    $('correct_answer').observe('click', this.answered_correctly.bindAsEventListener(this));
    $('wrong_answer').observe('click', this.answered_wrong.bindAsEventListener(this));

    // begin
    this.next_card();
  },

  next_card: function(answer_result) {
    $('processing').show();

    new Ajax.Request(this.next_path, {
      method: 'POST',
      parameters: {correct: answer_result},
      onSuccess: function(response) {
        var text = response.responseJSON.front;

        var quiz_status = response.responseJSON.quiz_status;
        $('answered_correctly_count').update(quiz_status.num_correct + "/" + quiz_status.num_answered);
        $('percentage_correct').update(Math.floor("" + quiz_status.percent_correct*100) + "%");
        $('cards_remaining').update(quiz_status.num_remaining);

        if(text == "no more cards") {
          this.end_game();
        } else {
          this.card_status = "hidden";
          $('card_front_value').update(text);
          $('card_back_value').update("");
          $('card_back').addClassName("dashed-border").removeClassName("solid-border");
        }
        $('flip_link').show();
        $('processing').hide();
      }.bind(this)
    });
  },

  flip_card: function(evt) {
    evt.stop();
    $('processing').show();
    new Ajax.Request(this.back_path, {
      method: 'GET',
      onSuccess: function(response) {
        this.card_status = "revealed";
        $('card_back_value').update(response.responseText);
        $('card_back').addClassName("solid-border").removeClassName("dashed-border");
        $('processing').hide();
      }.bind(this)
    });
  },

  end_game: function() {
    $('quiz_nav').hide();
  },

  answered_correctly: function(evt) {
    evt.stop();
    this.next_card("correct");
  },

  answered_wrong: function(evt) {
    evt.stop();
    this.next_card("incorrect");
  }
});

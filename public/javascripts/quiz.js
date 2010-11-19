Quiz = Class.create({
  initialize: function(options) {
    this.back_path = options.back_path;
    this.next_path = options.next_path;
    this.card_status = "hidden";


    $('reveal_card_link').observe('click', this.reveal_back.bindAsEventListener(this));
    $('correct_answer').observe('click', this.answered_correctly.bindAsEventListener(this));
    $('wrong_answer').observe('click', this.answered_wrong.bindAsEventListener(this));

    // begin
    this.next_card();
  },

  next_card: function(answer_result) {
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
      }.bind(this)
    });
  },

  reveal_back: function(evt) {
    evt.stop();
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

  end_game: function() {
    $('quiz_nav').hide();
    $('correct_links_area').hide();
    $('site_nav').show();
  },

  answered_correctly: function(evt) {
    evt.stop();
    $('reveal_card_link').show();
    $('correct_links_area').hide();
    this.next_card("correct");
  },

  answered_wrong: function(evt) {
    evt.stop();
    $('reveal_card_link').show();
    $('correct_links_area').hide();
    this.next_card("incorrect");
  }
});

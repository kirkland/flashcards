NewQuiz = Class.create({
  initialize: function(quiz_data) {
    this.quiz_data = quiz_data;
    $('quiz_card').observe('click', this.flip_card.bindAsEventListener(this));
  },

  flip_card: function() {
    if (this.front_showing == true) {
      $('quiz_card_content').update(this.active_card().back);
      this.front_showing = false;
    } else {
      $('quiz_card_content').update(this.active_card().front);
      this.front_showing = true;
    }
  },

  active_card: function() {
    rv = this.quiz_data.detect(function(qc) {
      return qc.active == true;
    });
    return rv;
  },

  show_active_card: function() {
    $('quiz_card_content').update("hey");
  },
});

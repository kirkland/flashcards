NewQuiz = Class.create({
  initialize: function(quiz_data) {
    this.quiz_data = quiz_data;
    this.show_active_card();
    $('quiz_card').observe('click', this.flip_card.bindAsEventListener(this));
  },

  flip_card: function() {
    if (this.front_showing == true) {
      this.front_showing = false;
    } else {
      this.front_showing = true;
    }
    this.show_active_card();
  },

  show_active_card: function() {
    if (this.front_showing == true) {
      $('quiz_card_content').update(this.active_card().front);
    } else {
      $('quiz_card_content').update(this.active_card().back);
    }
  },

  active_card: function() {
    rv = this.quiz_data.detect(function(qc) {
      return qc.active == true;
    });
    return rv;
  },

  next_card: function () {
  },
});

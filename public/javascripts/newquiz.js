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
    return this.quiz_data[this.find_active_card_index()];
  },

  find_active_card_index: function() {
    var rv = 0;
    this.quiz_data.each(function(qc, index) {
      if (qc.active == true) {
        rv = index;
      }
    });
    return rv;
  },

  next_card: function () {
  },
});

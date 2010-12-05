NewQuiz = Class.create({
  initialize: function(quiz_cards, update_path) {
    this.quiz_cards = quiz_cards;
    this.update_path = update_path;
    this.front_showing = true;
    this.show_active_card();

    $('quiz_card').observe('click', this.flip_card.bindAsEventListener(this));
    $('right_arrow').observe('click', this.next_card.bindAsEventListener(this));
    $('left_arrow').observe('click', this.prev_card.bindAsEventListener(this));
    $('correct_link').observe('click', this.mark_correct.bindAsEventListener(this));
    $('incorrect_link').observe('click', this.mark_incorrect.bindAsEventListener(this));
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
    return this.quiz_cards[this.find_active_card_index()];
  },

  // if we don't know yet what card is active, look through all
  // cards, or return 0 if none are set as active
  find_active_card_index: function() {
    if (typeof this.active_card_index != "undefined") {
      return this.active_card_index;
    }

    var rv = 0;
    this.quiz_cards.each(function(qc, index) {
      if (qc.active == true) {
        rv = index;
      }
    });
    this.active_card_index = rv;
    return this.active_card_index;
  },

  next_card: function () {
    if (this.find_active_card_index() == this.quiz_cards.length - 1) {
      alert("End of the deck!");
    } else {
      this.front_showing = true;
      this.active_card_index += 1;
      this.show_active_card();
    }
  },

  prev_card: function () {
    if (this.find_active_card_index() == 0) {
      alert("Beginning of deck!");
    } else {
      this.front_showing = true;
      this.active_card_index -= 1;
      this.show_active_card();
    }
  },

  mark_correct: function () {
    this.active_card().correct = true;
  },

  mark_incorrect: function () {
    this.active_card().correct = false;
  },

  update_params: function () {
    var data = this.quiz_cards.collect(function (qc) {
      var subset = new Object();
      subset.correct = qc.correct;
      subset.active = qc.active;
      subset.visited = qc.visited;
      return subset;
    });
    return data;
  },

  update_db: function () {
    new Ajax.Request(this.update_path, {
      parameters: this.update_params(),
    });
  },
});

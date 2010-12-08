Quiz = Class.create({
  initialize: function(quiz_data, update_path) {
    this.quiz_cards = quiz_data.quiz_cards;
    this.active_card_id = quiz_data.active_card_id;
    this.update_path = update_path;
    this.front_showing = true;

    $('quiz_card').observe('click', this.flip_card.bindAsEventListener(this));
    $('right_arrow').observe('click', this.next_card.bindAsEventListener(this));
    $('left_arrow').observe('click', this.prev_card.bindAsEventListener(this));
    $('correct_link').observe('click', this.mark_correct.bindAsEventListener(this));
    $('incorrect_link').observe('click', this.mark_incorrect.bindAsEventListener(this));

    this.refresh();

    // on first load, need to set that first card as visited
    this.update_db({active_card_id: this.active_card().qc_id});
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
      if (this.active_card_id == qc.qc_id) {
        rv = index;
      }
    }.bind(this));
    this.active_card_index = rv;
    return this.active_card_index;
  },

  refresh: function() {
    this.active_card().visited = true;
    if (this.front_showing == true) {
      $('quiz_card_content').update(this.active_card().front);
    } else {
      $('quiz_card_content').update(this.active_card().back);
    }
  },

  update_db: function (active_card_id, params) {
    if (params == null) params = new Object();
    params.active_card_id = active_card_id;

    new Ajax.Request(this.update_path, {
      parameters: params,
    });
  },

  // user methods
  flip_card: function() {
    this.front_showing = this.front_showing ? false : true
    this.refresh();
  },

  next_card: function () {
    if (this.find_active_card_index() == this.quiz_cards.length - 1) {
      alert("End of the deck!");
    } else {
      this.front_showing = true;
      this.active_card_index += 1;
      this.refresh();
      this.update_db(this.active_card().qc_id);
    }
  },

  prev_card: function () {
    if (this.find_active_card_index() == 0) {
      alert("Beginning of deck!");
    } else {
      this.front_showing = true;
      this.active_card_index -= 1;
      this.refresh();
      this.update_db(this.active_card().qc_id);
    }
  },

  mark_correct: function () {
    this.active_card().correct = true;
    var correct_card = this.active_card().qc_id;
    if (this.find_active_card_index() == this.quiz_cards.length - 1) {
      alert("End of the deck!");
    } else {
      this.front_showing = true;
      this.active_card_index += 1;
      this.refresh();
    }
    this.update_db(this.active_card().qc_id, {correct_card: correct_card});
  },

  mark_incorrect: function () {
    this.active_card().correct = false;
    var incorrect_card = this.active_card().qc_id;
    if (this.find_active_card_index() == this.quiz_cards.length - 1) {
      alert("End of the deck!");
    } else {
      this.front_showing = true;
      this.active_card_index += 1;
      this.refresh();
    }
    this.update_db(this.active_card().qc_id, {incorrect_card: incorrect_card});
  },
});

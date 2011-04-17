Quiz = Class.create({
  initialize: function(quiz_data, update_path, browser_type) {
    this.quiz_cards = quiz_data.quiz_cards;
    this.update_path = update_path;
    this.front_showing = true;
    this.active_card_index = this.find_active_card_index(quiz_data.active_card_id);

    if (browser_type == 'phone') {
      $('quiz_card_content').observe('click', this.flip_card.bindAsEventListener(this));
    } else {
      $('quiz_card_content').observe('mouseover', this.flip_card_back.bindAsEventListener(this));
      $('quiz_card_content').observe('mouseout', this.flip_card_front.bindAsEventListener(this));
    }

    $('right_arrow').observe('click', this.next_card.bindAsEventListener(this));
    $('left_arrow').observe('click', this.prev_card.bindAsEventListener(this));
    $('correct_link').observe('click', this.mark_correct.bindAsEventListener(this));
    $('incorrect_link').observe('click', this.mark_incorrect.bindAsEventListener(this));

    this.refresh();

    // on first load, need to set that first card as visited
    this.update_db({active_card_id: this.active_card().id});
  },

  // called in initialize only
  // active_card_id will be null if this is a brand new quiz
  find_active_card_index: function(active_card_id) {
    if (null == active_card_id) return 0;

    var rv = 0;
    this.quiz_cards.each(function(qc, index) {
      if (active_card_id == qc.id) {
        rv = index;
      }
    }.bind(this));
    return rv;
  },

  active_card: function() {
    return this.quiz_cards[this.active_card_index];
  },

  refresh: function() {
    $('quiz_card_content').update(this.front_showing ? this.active_card().front : this.active_card().back);

    // show a selected button if we know correct/incorrect
    if (this.active_card().correct == true ) {
      $('correct_link').addClassName('selected');
      $('incorrect_link').removeClassName('selected');
    } else if (this.active_card().correct == false) {
      $('incorrect_link').addClassName('selected');
      $('correct_link').removeClassName('selected');
    } else {
      $('correct_link').removeClassName('selected');
      $('incorrect_link').removeClassName('selected');
    }

    var new_url = 'audioUrl=' + this.active_card().sound_url;
    if (new_url.match(/missing.png$/) || this.sound_url != new_url) {
      if (null != $('sound_embed')) {
        $('sound_embed').remove();
      }
    }

    if (!new_url.match(/missing.png$/) && this.sound_url != new_url) {
      $('sound').insert({bottom: new Element('embed', {id: 'sound_embed', height: "27", width: "400", src: "http://www.google.com/reader/ui/3523697345-audio-player.swf", pluginspage: "http://www.macromedia.com/go/getflashplayer", flashvars: new_url})});
    }

    this.sound_url = new_url;
  },

  update_db: function (params) {
    if (params == null) params = new Object();
    params.active_card_id = this.active_card().id;

    new Ajax.Request(this.update_path, {
      parameters: params,
      onSuccess: function (resp) {
        this.quiz_status = resp.responseJSON;
        if (quiz_status.error != undefined && $('flash-error') == undefined) {
          $('quiz').insert({top: new Element('div', {'id': 'flash-error'}).insert(new Element('ul').insert(new Element('li').update(quiz_status.error)))});
        }
        $('cards_correct').update(this.quiz_status.num_correct);
        $('cards_answered').update(this.quiz_status.num_answered);
        $('cards_remaining').update(this.quiz_status.num_remaining);
      }
    });
  },

  flip_card_front: function() {
    this.front_showing = true;
    this.refresh();
  },

  flip_card_back: function() {
    this.front_showing = false;
    this.refresh();
  },

  flip_card: function() {
    this.front_showing = !this.front_showing;
    this.refresh();
  },

  next_card: function () {
    if (this.active_card_index == this.quiz_cards.length - 1) {
      $('review_message').update("End of the deck!");
      $('review_message').show();
    } else {
      $('review_message').update('').hide();
      this.front_showing = true;
      this.active_card_index += 1;
      this.refresh();
      this.update_db();
    }
  },

  prev_card: function () {
    if (this.active_card_index == 0) {
      $('review_message').update("Beginning of the deck!");
      $('review_message').show();
    } else {
      $('review_message').update('').hide();
      this.front_showing = true;
      this.active_card_index -= 1;
      this.refresh();
      this.update_db();
    }
  },

  mark_correct: function () {
    this.active_card().correct = true;
    var correct_card = this.active_card().id;
    // show a selected button if we know correct/incorrect
    if (this.active_card().correct == true ) {
      $('correct_link').addClassName('selected');
      $('incorrect_link').removeClassName('selected');
    } else if (this.active_card().correct == false) {
      $('incorrect_link').addClassName('selected');
      $('correct_link').removeClassName('selected');
    } else {
      $('correct_link').removeClassName('selected');
      $('incorrect_link').removeClassName('selected');
    }
    if (this.active_card_index == this.quiz_cards.length - 1) {
      $('review_message').update("End of the deck!");
      $('review_message').show();
    } else {
      this.front_showing = true;
      this.active_card_index += 1;
      this.refresh();
    }
    this.update_db({correct_card: correct_card});
  },

  mark_incorrect: function () {
    this.active_card().correct = false;
    // show a selected button if we know correct/incorrect
    if (this.active_card().correct == true ) {
      $('correct_link').addClassName('selected');
      $('incorrect_link').removeClassName('selected');
    } else if (this.active_card().correct == false) {
      $('incorrect_link').addClassName('selected');
      $('correct_link').removeClassName('selected');
    } else {
      $('correct_link').removeClassName('selected');
      $('incorrect_link').removeClassName('selected');
    }
    var incorrect_card = this.active_card().id;
    if (this.active_card_index == this.quiz_cards.length - 1) {
      $('review_message').update("End of the deck!");
      $('review_message').show();
    } else {
      this.front_showing = true;
      this.active_card_index += 1;
      this.refresh();
    }
    this.update_db({incorrect_card: incorrect_card});
  },
});

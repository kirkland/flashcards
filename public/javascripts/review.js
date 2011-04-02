Review = Class.create({
  initialize: function(cards, mobile) {
    this.cards = cards;
    this.front_showing = true;
    this.active_card_index = 0;

    if (mobile) {
      $('quiz_card_content').observe('click', this.flip_card.bindAsEventListener(this));
    } else {
      $('quiz_card_content').observe('click', this.next_card.bindAsEventListener(this));
      $('quiz_card_content').observe('mouseover', this.flip_card_back.bindAsEventListener(this));
      $('quiz_card_content').observe('mouseout', this.flip_card_front.bindAsEventListener(this));
    }

    $('right_arrow').observe('click', this.next_card.bindAsEventListener(this));
    $('left_arrow').observe('click', this.prev_card.bindAsEventListener(this));

    this.refresh();
  },

  active_card: function() {
    return this.cards[this.active_card_index];
  },

  refresh: function() {
    $('quiz_card_content').update(this.front_showing ? this.active_card().front : this.active_card().back);

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
    if (this.active_card_index == this.cards.length - 1) {
      $('review_message').update("End of the deck!");
      $('review_message').show();
    } else {
      $('review_message').update('').hide();
      this.front_showing = this.front_showing = true;
      this.active_card_index += 1;
      this.refresh();
    }
  },

  prev_card: function () {
    if (this.active_card_index == 0) {
      $('review_message').update("Beginning of the deck!");
      $('review_message').show();
    } else {
      $('review_message').update('').hide();
      this.front_showing = this.front_showing = true;
      this.active_card_index -= 1;
      this.refresh();
    }
  },
});
